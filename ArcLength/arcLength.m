function [tangentialForce, dispAtIncrement, numIteration] = arcLength(XYZ, supports, connectivity, materials, sections, materialIds, nodalLoads, sectionIds, deltaL, phi, tolerance, maxIteration, numIncrement, elementTypes)
numNode = size(XYZ, 1);

[nEq, numDof] = getEquaitonNumbering(numNode, supports);

dispAtIncrement = zeros(numDof, numIncrement+1);
tangentialForce = zeros(numDof, numIncrement+1);

[Kg, elements, nodes] = constructNonlinearElements(XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds, dispAtIncrement);

F = getLoadVector(nodalLoads, nodes);




lambda = zeros(1, numIncrement+1);

for i=1:numIncrement
    numIteration(i) = 1;
    
    Kt = nonlinearTangentStiffnessBeam(dispAtIncrement, elements, numDof, nodes);%Look at this
    Upt = solveForDisplacement(F, Kt);
    
    a1 = (Upt')*Upt+ phi^2 * (F')*F;
    a2 = 0;
    a3 = -deltaL^2;
    [incLambda(1),incLambda(2)] = solveLambda(a1,a2,a3);
    
    dKt = det(Kt);
    if ((incLambda(1) / dKt) > 0)
        deltaU = incLambda(1)*Upt;
        deltaLambda = incLambda(1);
    else
        deltaU = incLambda(2)*Upt;
        deltaLambda = incLambda(2);
    end
    
    deltaU0 = deltaU;
    deltaLambda0 = deltaLambda;
    deltaUp = deltaU;
    deltaLambdap = deltaLambda;
    
    UT = dispAtIncrement(:,i) + deltaU0;
    lambdaT = lambda(i) + deltaLambda;
    
    while numIteration(i) <= maxIteration
        Kt = nonlinearTangentStiffnessBeam(UT, elements, numDof, nodes);
        fi = nonlinearInternalForceBeam(UT, elements, numDof, nodes);
        fe = lambdaT * F;
        Re = fi - fe;
        
        if (norm(Re) < tolerance)
            break;
        end
        
        Uph = solveForDisplacement(-Re, Kt);
        Upt = solveForDisplacement(F, Kt);
        
        a1 = (Upt')*Upt+ phi^2 * (F')*F;
        a2 = 2 * Upt' * (Uph + deltaU0) + 2 * deltaLambda0 * phi^2 * (F')*F;
        a3 = (Uph + deltaU0)' * (Uph + deltaU0) - deltaL^2 + deltaLambda0^2 * (phi^2 * (F')*F);
        [incLambda(1),incLambda(2)] = solveLambda(a1,a2,a3);
        
        [deltaULambda1,deltaULambda2] = chooseSolution(incLambda, deltaU, deltaUp, Uph, Upt, deltaLambda, deltaLambdap, phi, F);
        deltaLambdap = deltaLambda;
        deltaUp = deltaU;
        deltaLambda = deltaULambda2;
        deltaU = deltaULambda1;
        UT = dispAtIncrement(:,i) + deltaU;
        lambdaT = lambda(i) + deltaLambda;
        numIteration(i) = numIteration(i) + 1;
    end
    
    dispAtIncrement(:,i+1) = UT;
    lambda(i+1) = lambda(i) + deltaLambda;
    tangentialForce(:,i+1) = lambda(i+1) * F;
end

end