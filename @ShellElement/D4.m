function D4 = D4(this, ksi, eta)

dN4k = this.dN4_dKsi(ksi, eta);
dN4e = this.dN4_dEta(ksi, eta);

for i = 1:4
    D4(1,i) = dN4k(i);
    D4(2,i) = dN4e(i);
end

end
