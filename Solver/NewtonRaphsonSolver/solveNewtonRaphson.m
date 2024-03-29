function [U,force,inertias,moments,internalForces,numberOfIterations,displacementIterations,curvatures] = solveNewtonRaphson(elements, K, F, n, mIt, tol)

% Initialization of variables.
numEqn = size(K,1);
deltaF = (1/n)*F;
U = zeros(numEqn,1);
numberOfIterations = zeros(1,1);
force = zeros(numEqn,1);
fe = zeros(numEqn,1);
displacementIterations = zeros(numEqn, 1);

% Hold extra information.
inertias = zeros(size(elements,2),n+1);
curvatures = zeros(size(elements,2),n+1,5);
for elemId = 1: size(elements,2)
    for gaussPoint=1:5
     	inertias(elemId,1,gaussPoint) = elements{elemId}.Izeff(gaussPoint);
    end
    curvatures(elemId,1,:) = elements{elemId}.calculateCurvature(U(:,1));
    moments(elemId,1,:) = elements{elemId}.calculateInternalMoments(U(:,1));
    internalForces{elemId,1} = elements{elemId}.calculateInternalForces(U(:,1),true);
end

% Initialize tangent stiffness.
Kt = constructGlobalStiffness(elements, numEqn, true);

% Start increments.
for i=1:n

    % Check for singularity.
    if (cond(Kt) > 1e15)
        "Singular stiffness matrix in the increment " + num2str(i)
        return;
    end

	deltaU = solveForDisplacement(deltaF,Kt);
	Uc = U(:,i) + deltaU;
	fe = fe + deltaF;
	
    % Update tangent stiffness.
	for elemId = 1: size(elements,2)
		element = elements{elemId};
		element.updateStiffness(Uc);
	end
	Kt = constructGlobalStiffness(elements, numEqn, true);
	
    % Start iterations.
	nIt = 0;
	while nIt < mIt
		nIt = nIt + 1;
        
        % Calculate internal forces.
        fi = zeros(numEqn,1);
        for elemId = 1: size(elements,2)
            elemInternalForces = elements{elemId}.calculateInternalForces(Uc,true);
            for node = 1:2
                for dof = 1:6
                    globalDofId = elements{elemId}.eqnNumbering(node,dof);
                    if (globalDofId ~= 0)
                        fi(globalDofId) = fi(globalDofId) + elemInternalForces(node,dof);
                    end
                end
            end
        end 
                
        % Residual forces.
		R = fi - fe;
        
        % Check for singularity.
        if (cond(Kt) > 1e15)
            "Singular stiffness matrix in the increment " + num2str(i) + " and iteration " + num2str(nIt)
            return;
        end

        % Store history of iterations.
        solveForDisplacement(-R,Kt);
        displacementIterations(:,end+1) = Uc + solveForDisplacement(-R,Kt);

        % If residual is smaller than tolerance, stop this iteration.
        if norm(R) < tol
			break;
        end
		
		dellU = solveForDisplacement(-R,Kt);
		Uc = Uc + dellU;

        if (nIt >= mIt)
            "Maximum iteration has been reached. Could'nt converge the result."
            return;
        end
	end
	
	U(:,i+1) = Uc;
	force(:,i+1) = fe;
    numberOfIterations(i+1) = nIt;

    % Hold extra information.
	for elemId = 1: size(elements,2)
        for gaussPoint=1:5
            inertias(elemId,i+1,gaussPoint) = elements{elemId}.Izeff(gaussPoint);
        end
        curvatures(elemId,i+1,:) = elements{elemId}.calculateCurvature(Uc);
        moments(elemId,i+1,:) = elements{elemId}.calculateInternalMoments(Uc);
        internalForces{elemId,i+1} = elements{elemId}.calculateInternalForces(Uc,true);
	end
	
end

end