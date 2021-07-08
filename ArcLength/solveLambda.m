function [incLambda1, incLambda2] = solveLambda(a1,a2,a3)
	if ~(a1 == 0 && a2 == 0)
		if (a1 == 0  && a3 ~= 0)
			incLambda1 = -(a3/a2);
			incLambda2 = incLambda1;
		else 
			fact = a2^2 - 4*a1*a3;
			if fact >= 0
				incLambda1 = (-a2 + sqrt(fact)) / (2*a1);
				incLambda2 = (-a2 - sqrt(fact)) / (2*a1);
			else
				incLambda1 = 0;
				incLambda2 = 0;
			end
		end
	else
		incLambda1 = 0;
		incLambda2 = 0;
	end
end
