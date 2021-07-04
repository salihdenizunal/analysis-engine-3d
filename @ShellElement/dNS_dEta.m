function dNS_dEta = dNS_dEta(this, ksi, eta)

dNS_dEta =  [2 * eta - ksi^2 - 2 * eta*ksi + ksi;
    2 * eta - ksi^2 + 2 * eta*ksi - ksi;
    2 * eta + ksi^2 + 2 * eta*ksi + ksi;
    2 * eta + ksi^2 - 2 * eta*ksi - ksi;
    -2 + 2 * ksi^2;
    -4 * (1 + ksi)*eta;
    2 - 2 * ksi^2;
    4 * (-1 + ksi)*eta];

dNS_dEta = (1 / 4) * dNS_dEta;

end
