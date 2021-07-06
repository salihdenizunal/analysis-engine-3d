function [U,force,inertias] = solveCrack(elements, K, F, n, mIt, tol)

numEqn = size(K,1);
deltaF = (1/n)*F;
U = zeros(numEqn,n+1);
force = zeros(numEqn,n+1);
fe = zeros(numEqn,1);

inertias = zeros(size(elements,2),n+1);
for elemId = 1: size(elements,2)
    for gaussPoint=1:5
     	inertias(elemId,1,gaussPoint) = elements{elemId}.Ieff(gaussPoint);
    end
end

for i=1:n
	K = constructGlobalStiffness(elements, numEqn);
	deltaU = solveForDisplacement(deltaF,K);
	Uc = U(:,i) + deltaU;
	fe = fe + deltaF;
	
	for elemId = 1: size(elements,2)
		element = elements{elemId};
		element.updateStiffness(Uc);
	end
	
	nIt = 0;
	while nIt < mIt
		nIt = nIt + 1;
		fi = getInternalForcesCrackedBeam(elements,numEqn,Uc);
		R = fi - fe;
		if norm(R) < tol
			break;
		end
		
		for elemId = 1: size(elements,2)
			element = elements{elemId};
			element.updateStiffness(Uc);
		end
		Kt = constructGlobalStiffness(elements, numEqn);
		
		dellU = solveForDisplacement(-R,Kt);
		Uc = Uc + dellU;
	end
	
	U(:,i+1) = Uc;
	force(:,i+1) = fe;

	for elemId = 1: size(elements,2)

    for gaussPoint=1:5
     	inertias(elemId,i+1,gaussPoint) = elements{elemId}.Ieff(gaussPoint);
    end

	end
	
end

end