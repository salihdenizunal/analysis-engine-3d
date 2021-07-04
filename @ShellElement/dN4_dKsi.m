function dN4_dKsi = dN4_dKsi(this, ksi, eta)

dN4_dKsi = [-(1-eta); (1-eta); (1+eta); -(1+eta)];
dN4_dKsi = 0.25 * dN4_dKsi;

end
