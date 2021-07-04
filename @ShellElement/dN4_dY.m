function dN4_dY = dN4_dY(this, JI, ksi, eta)

dN4_dK = this.dN4_dKsi(ksi, eta);
dN4_dE = this.dN4_dEta(ksi, eta);

dN4_dY = [JI(2,1)*dN4_dK(1) + JI(2,2)*dN4_dE(1);
    JI(2,1)*dN4_dK(2) + JI(2,2)*dN4_dE(2);
    JI(2,1)*dN4_dK(3) + JI(2,2)*dN4_dE(3);
    JI(2,1)*dN4_dK(4) + JI(2,2)*dN4_dE(4)];

end
	