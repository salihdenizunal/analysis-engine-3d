function [delta_u_f,delta_lambda_f] = chooseSolution(dell_lambda, delta_u, delta_u_0, u_ph, u_pt, delta_lambda, delta_lambda_0, phi, F)
	u_p = u_ph + dell_lambda(1) * u_pt;
	delta_u_1 = delta_u + u_p;
	delta_lambda_1 = delta_lambda + dell_lambda(1);
	D1 = delta_u_1' * delta_u_0 + phi^2 * delta_lambda_0 * delta_lambda_1 * (F') * F;

	u_p = u_ph + dell_lambda(2) * u_pt;
	delta_u_2 = delta_u + u_p;
	delta_lambda_2 = delta_lambda + dell_lambda(2);
	D2 = delta_u_2' * delta_u_0 + phi^2 * delta_lambda_0 * delta_lambda_2 * (F') * F;
	
	if (D1 > D2)
		delta_u_f = delta_u_1;
		delta_lambda_f = delta_lambda_1;
	else
		delta_u_f = delta_u_2;
		delta_lambda_f = delta_lambda_2;
	end
end
