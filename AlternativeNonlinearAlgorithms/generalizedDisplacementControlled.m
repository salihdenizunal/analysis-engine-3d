function [internalForce, dispAtIncrement, numIteration] = generalizedDisplacementControlled(XYZ, supports, elements, nodes, nodalLoads, tolerance, maxIteration, numIncrement)
n = (1/numIncrement);

lambda(1) = 0.1;

numNode = size(XYZ, 1);

[nEq, numDof] = getEquaitonNumbering(numNode, supports);

dispAtIncrement = zeros(numDof, numIncrement+1);
tangentialForce = zeros(numDof, numIncrement+1);
internalForce = zeros(numDof, numIncrement+1);
du = zeros(numDof, numIncrement+1);

F = getLoadVector(nodalLoads, nodes);

deltaF = n*F;

for i = 1:numIncrement
     numIteration(i) = 1;
     Kt = nonlinearTangentStiffnessBeam(dispAtIncrement(:,i), elements, numDof, nodes);
     du(:, i) = solveForDisplacement(deltaF, Kt);
     du1(:, i) = du(:, i);
     if i == 1
         GSP = 1;
     else
         GSP = ((du(:, 1))'*(du(:, 1)))/((du(:, i-1))'*(du(:, i)));
     end
     lambda(i) = lambda(1)*sqrt(abs(GSP));
     if GSP<0
         lambda(i) = -lambda(i);
     end
     deltaU(:,i) = lambda(i)*  du(:, i); 
     
     dispAtIncrement(:,i) = dispAtIncrement(:,i) + deltaU(:,i);
     tangentialForce(:,i) = tangentialForce(:,i) + lambda(i)*deltaF;
     
     dP = nonlinearInternalForceBeam(deltaU(:,i), elements, numDof, nodes);
     
     
     internalForce(:,i) = internalForce(:,i) + dP;
     
     R(:,i) = tangentialForce(:,i) - internalForce(:,i);
    
     err = norm(R(:,i))/norm(deltaF);
     while((err>tolerance)  && (numIteration(i)<maxIteration))
         Kt = nonlinearTangentStiffnessBeam(dispAtIncrement(:,i), elements, numDof, nodes);
         du(:, i) = solveForDisplacement(deltaF, Kt);
         dDotU(:, i) = solveForDisplacement(R(:,i), Kt);
         if numIteration(i) == 1
            dDotU1(:, i) = dDotU(:, i);
         end
         
         
         if i ==1
            lambda(i) = -((du1(:, 1))'*(dDotU(:, i)))/((du1(:, 1))'*(du(:, i)));   
         else
             lambda(i) = -((du1(:, i-1))'*(dDotU(:, i)))/((du1(:, i-1))'*(du(:, i)));   
         end
         
         deltaU(:,i) = lambda(i)*  du1(:, i)  + dDotU1(:, i); 
         dispAtIncrement(:,i) = dispAtIncrement(:,i) + deltaU(:,i);
         
         tangentialForce(:,i) = tangentialForce(:,i) + lambda(i)*deltaF;

         dP = nonlinearInternalForceBeam(deltaU(:,i), elements, numDof, nodes);


         internalForce(:,i) = internalForce(:,i) + dP;

         R(:,i) = tangentialForce(:,i) - internalForce(:,i);

         err = norm(R(:,i))/norm(deltaF);
         
         numIteration(i) = numIteration(i) + 1;
         
     end
end


end