function [internalForce, dispAtIncrement, numIteration] = alternateNonlinearAlgorithm(XYZ, supports, elements, nodes, nodalLoads, tolerance, maxIteration, numIncrement)
numNode = size(XYZ, 1);

[nEq, numDof] = getEquaitonNumbering(numNode, supports);

dispAtIncrement = zeros(numDof, numIncrement+1);
tangentialForce = zeros(numDof, numIncrement+1);
internalForce = zeros(numDof, numIncrement+1);

F = getLoadVector(nodalLoads, nodes);
for n = 1:numIncrement
    numIteration(n) = 1;
    
    df = F*(1/numIncrement);
    Kt = nonlinearTangentStiffnessBeam(dispAtIncrement(:,n), elements, numDof, nodes);
    du = solveForDisplacement(df, Kt);
    dispAtIncrement(:,n+1) = (dispAtIncrement(:,n) + du);
    tangentialForce(:,n+1) =  (tangentialForce(:,n) + df);
    
    Ucurrent = dispAtIncrement(:,n+1);
    
    internalForce(:,n+1) = nonlinearInternalForceBeam(Ucurrent, elements, numDof, nodes);
    
    R = (internalForce(:,n+1) - tangentialForce(:,n+1));
    
    normR = norm(R);
    
    deltaUk = zeros(numDof,1);
    
    fi = internalForce(:,n+1);
    while ((normR>tolerance)  && (numIteration(n)<maxIteration))
        
        Kt = nonlinearTangentStiffnessBeam(Ucurrent, elements, numDof, nodes);
        
        deltaUk = (deltaUk - solveForDisplacement(R, Kt));
        
        Ucurrent = (dispAtIncrement(:,n+1) + deltaUk);
        
        fi = nonlinearInternalForceBeam(Ucurrent, elements, numDof, nodes);
        
        R = (fi - tangentialForce(:,n+1));
        
        normR = norm(R);
        
        numIteration(n) = numIteration(n) + 1;
        
    end
    internalForce(:,n+1) = fi;
    
    dispAtIncrement(:,n+1) = (dispAtIncrement(:,n+1) + deltaUk);
    
end

end