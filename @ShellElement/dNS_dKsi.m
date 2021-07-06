function dNS_dKsi = dNS_dKsi(this, ksi, eta)

dNS_dKsi =  [2 * ksi - 2 * eta*ksi - eta^2 + eta;
    2 * ksi - 2 * eta*ksi + eta^2 - eta;
    2 * ksi + 2 * eta*ksi + eta^2 + eta;
    2 * ksi + 2 * eta*ksi - eta^2 - eta;
    4 * ksi*(-1 + eta);
    2 - 2 * eta^2;
    -4 * ksi*(1 + eta);
    -2 + 2 * eta^2];

dNS_dKsi = (1 / 4) * dNS_dKsi;

end
