function [U,force,inertias,moments,internalForces,numberOfIterations,displacementIterations,curvatures] = solveCrack(elements, K, F, n, mIt, tol)

% Initialization of variables.
numEqn = size(K,1);
deltaF = (1/n)*F;
U = zeros(numEqn,n+1);
numberOfIterations = zeros(1,n+1);
force = zeros(numEqn,n+1);
fe = zeros(numEqn,1);
displacementIterations = zeros(numEqn, 1);

% Hold extra information.
inertias = zeros(size(elements,2),n+1);
curvatures = zeros(size(elements,2),n+1,5);
for elemId = 1: size(elements,2)
    for gaussPoint=1:5
     	inertias(elemId,1,gaussPoint) = elements{elemId}.Ieff(gaussPoint);
    end
    curvatures(elemId,1,:) = elements{elemId}.calculateCurvature(U);
    moments(elemId,1,:) = elements{elemId}.calculateInternalMoments(U);
    internalForces{elemId,1} = elements{elemId}.calculateInternalForces(U);
end

% Initialize tangent stiffness.
Kt = constructGlobalStiffness(elements, numEqn);

% Start increments.
for i=1:n
	deltaU = solveForDisplacement(deltaF,Kt);
	Uc = U(:,i) + deltaU;
	fe = fe + deltaF;
	
    % Update tangent stiffness.
	for elemId = 1: size(elements,2)
		element = elements{elemId};
		element.updateStiffness(Uc);
	end
	Kt = constructGlobalStiffness(elements, numEqn);
	
    % Start iterations.
	nIt = 0;
	while nIt < mIt
		nIt = nIt + 1;
        
        % Calculate internal forces.
        fi = zeros(numEqn,1);
        for elemId = 1: size(elements,2)
            elemInternalForces = elements{elemId}.calculateInternalForces(Uc);
            for dof1 = 1:2
                for dof2 = 1:6
                    globalDofId = elements{elemId}.eqnNumbering(dof1,dof2);
                    if (globalDofId ~= 0)
                        fi(globalDofId) = fi(globalDofId) + elemInternalForces(dof1,dof2);
                    end
                end
            end
        end 
                
        % Residual forces.
		R = fi - fe;
        
        % Store history of iterations.
        displacementIterations(:,end+1) = Uc + solveForDisplacement(-R,Kt);

        % If residual is smaller than tolerance, stop this iteration.
		if norm(R) < tol
			break;
        end
		
		dellU = solveForDisplacement(-R,Kt);
		Uc = Uc + dellU;
	end
	
	U(:,i+1) = Uc;
	force(:,i+1) = fe;
    numberOfIterations(i+1) = nIt;

    % Hold extra information.
	for elemId = 1: size(elements,2)
        for gaussPoint=1:5
            inertias(elemId,i+1,gaussPoint) = elements{elemId}.Ieff(gaussPoint);
        end
        curvatures(elemId,i+1,:) = elements{elemId}.calculateCurvature(Uc);
        moments(elemId,i+1,:) = elements{elemId}.calculateInternalMoments(Uc);
        internalForces{elemId,i+1} = elements{elemId}.calculateInternalForces(Uc);
	end
	
end

end