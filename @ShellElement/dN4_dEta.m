function dN4_dEta = dN4_dEta(this, ksi, eta)

dN4_dEta = [-(1-ksi); -(1+ksi); (1+ksi); (1-ksi)];
dN4_dEta = 0.25 * dN4_dEta;

end
