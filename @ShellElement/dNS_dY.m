function dNS_dY = dNS_dY(this, JI, ksi, eta)

dNS_dK = this.dNS_dKsi(ksi, eta);
dNS_dE = this.dNS_dEta(ksi, eta);

dNS_dY = [0;
    0;
    0;
    0;
    JI(2,1)*dNS_dK(5) + JI(2,2)*dNS_dE(5);
    JI(2,1)*dNS_dK(6) + JI(2,2)*dNS_dE(6);
    JI(2,1)*dNS_dK(7) + JI(2,2)*dNS_dE(7);
    JI(2,1)*dNS_dK(8) + JI(2,2)*dNS_dE(8)];

end
