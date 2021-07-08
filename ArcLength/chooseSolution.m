function [deltawf,deltaLambdaf] = ChooseSolution(incLambda, deltaU, deltaUp, Uph, Upt, deltaLambda, deltaLambda0, phi, F)

	wp = Uph + incLambda(1) * Upt;
	deltaw1 = deltaU + wp;
	deltaLambda1 = deltaLambda + incLambda(1);
	
	D1 = deltaw1' * deltaUp + phi^2 * deltaLambda0 * deltaLambda1 * (F') * F;
	wp = Uph + incLambda(2) * Upt;
	deltaw2 = deltaU + wp;
	deltaLambda2 = deltaLambda + incLambda(2);
	
	D2 = deltaw2' * deltaUp + phi^2 * deltaLambda0 * deltaLambda2 * (F') * F;
	
	if (D1 > D2)
		deltawf = deltaw1;
		deltaLambdaf = deltaLambda1;
	else
		deltawf = deltaw2;
		deltaLambdaf = deltaLambda2;
	end
end
