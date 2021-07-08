function [dell_lambda] = solveLambda(a_1,a_2,a_3)
	dell_lambda = [0, 0];

    if ~(a_1 == 0 && a_2 == 0)
        if (a_1 == 0  && a_3 ~= 0)
			dell_lambda(1) = (-a_3) / a_2;
			dell_lambda(2) = dell_lambda(1);
		else 
			fact = a_2^2 - 4*a_1*a_3;
			if fact >= 0
				dell_lambda(1) = ((-a_2) + sqrt(fact)) / (2*a_1);
				dell_lambda(2) = ((-a_2) - sqrt(fact)) / (2*a_1);
			end
        end
    end
end
