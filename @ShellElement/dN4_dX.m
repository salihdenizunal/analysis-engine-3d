function dN4_dX = dN4_dX(this, JI, ksi, eta)

dN4_dK = this.dN4_dKsi(ksi, eta);
dN4_dE = this.dN4_dEta(ksi, eta);

dN4_dX = [JI(1,1)*dN4_dK(1) + JI(1,2)*dN4_dE(1);
    JI(1,1)*dN4_dK(2) + JI(1,2)*dN4_dE(2);
    JI(1,1)*dN4_dK(3) + JI(1,2)*dN4_dE(3);
    JI(1,1)*dN4_dK(4) + JI(1,2)*dN4_dE(4)];

end
