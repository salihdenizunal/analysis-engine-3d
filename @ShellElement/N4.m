function N4 = N4(this, ksi, eta)

N4 = [(1 - ksi)*(1 - eta);
	(1 + ksi)*(1 - eta);
	(1 + ksi)*(1 + eta);
	(1 - ksi)*(1 + eta)];

N4 = (1 / 4) * N4;

end
