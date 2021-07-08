function [w, FT, internalForces] = solveArcLength(elements, K, F, numIncrements, maxIteration, tolerance, delta_L, phi)
    numEqn = size(K,1);

    w = zeros(numEqn, 1);
    lambda = zeros(1, 1);

    % Hold extra information.
    for elemId = 1: size(elements,2)
        internalForces{elemId,1} = elements{elemId}.calculateInternalForces(w(:,1),true);
    end

    for i = 1:numIncrements
        numIterations(i) = 1;

        % Update tangent stiffness.
        for elemId = 1: size(elements,2)
            element = elements{elemId};
            element.updateStiffness(w(:,i));
        end
        Kt = constructGlobalStiffness(elements, numEqn, true);

        % Check for singularity.
        if (cond(Kt) > 1e15)
            "Singular stiffness matrix in the increment " + num2str(i)
            return;
        end

        wpt = solveForDisplacement(F, Kt);

        a1 = (wpt') * wpt + phi^2 * (F') * F;
        a2 = 0;
        a3 = -delta_L^2;
        dell_lambda = solveLambda(a1, a2, a3);

        if ((dell_lambda(1) / det(Kt)) >= 0)
            delta_w = dell_lambda(1) * wpt;
            delta_lambda = dell_lambda(1);
        else
            delta_w = dell_lambda(2) * wpt;
            delta_lambda = dell_lambda(2);
        end

        delta_w0 = delta_w;
        delta_lambda0 = delta_lambda;
        delta_wp = delta_w;
        delta_lambdap = delta_lambda;

        wT = w(:,i) + delta_w0;
        lambdaT = lambda(i) + delta_lambda;

        % Start iterations. 
        while numIterations(i) <= maxIteration
            % Update tangent stiffness.
            for elemId = 1: size(elements,2)
                element = elements{elemId};
                element.updateStiffness(wT);
            end
            Kt = constructGlobalStiffness(elements, numEqn, true);

            % Calculate internal forces.
            fi = zeros(numEqn,1);
            for elemId = 1: size(elements,2)
                elemInternalForces = elements{elemId}.calculateInternalForces(wT,true);
                for node = 1:2
                    for dof = 1:6
                        globalDofId = elements{elemId}.eqnNumbering(node,dof);
                        if (globalDofId ~= 0)
                            fi(globalDofId) = fi(globalDofId) + elemInternalForces(node,dof);
                        end
                    end
                end
            end 

            fe = lambdaT * F;
            R = fi - fe;

            if (norm(R) < tolerance)
                break;
            end

            % Check for singularity.
            if (cond(Kt) > 1e15)
                "Singular stiffness matrix in the increment " + num2str(i) + " and iteration " + num2str(numIterations(i))
                return;
            end

            wph = solveForDisplacement(-R, Kt);
            wpt = solveForDisplacement(F, Kt);

            a1 = (wpt') * wpt + phi^2 * (F') * F;
            a2 = 2 * (wpt') * (wph + delta_w0) + 2 * delta_lambda0 * phi^2 * (F') * F;
            a3 = (wph + delta_w0)' * (wph + delta_w0) - delta_L^2 + delta_lambda0^2 * (phi^2 * (F') * F);
            dell_lambda = solveLambda(a1, a2, a3);

            [delta_w, delta_lambda] = chooseSolution(dell_lambda, delta_w, delta_wp, wph, wpt, delta_lambda, delta_lambdap, phi, F);
            delta_lambdap = delta_lambda;
            delta_wp = delta_w;
            wT = w(:,i) + delta_w;
            lambdaT = lambda(i) + delta_lambda;

            numIterations(i) = numIterations(i) + 1;
            if (numIterations(i) >= maxIteration)
                "Maximum iteration has been reached. Could'nt converge the result."
                return;
            end
        end

        w(:,i+1) = wT;
        lambda(i+1) = lambda(i) + delta_lambda;
        FT(:,i+1) = lambda(i+1) * F;

        % Hold extra information.
        for elemId = 1: size(elements,2)
            internalForces{elemId,i+1} = elements{elemId}.calculateInternalForces(wT,true);
        end
    end

end