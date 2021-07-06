function dNS_dX = dNS_dX(this, JI, ksi, eta)

dNS_dK = this.dNS_dKsi(ksi, eta);
dNS_dE = this.dNS_dEta(ksi, eta);

dNS_dX = [0;
    0;
    0;
    0;
    JI(1,1)*dNS_dK(5) + JI(1,2)*dNS_dE(5);
    JI(1,1)*dNS_dK(6) + JI(1,2)*dNS_dE(6);
    JI(1,1)*dNS_dK(7) + JI(1,2)*dNS_dE(7);
    JI(1,1)*dNS_dK(8) + JI(1,2)*dNS_dE(8)];

end
