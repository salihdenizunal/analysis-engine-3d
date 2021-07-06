function kD = AddDrilling(this, V)

kDia = (1/150000) * this.elasticityModulus * V;

for i = 1:4
    kD(3*i,3*i) = 1.75*kDia;
end

kD(3,6) = -0.75*kDia;
kD(3,9) = -0.25*kDia;
kD(3,12) = -0.75*kDia;
kD(6,9) = -0.75*kDia;
kD(6,12) = -0.25*kDia;
kD(9,12) = -0.75*kDia;
kD(6,3) = -0.75*kDia;
kD(9,3) = -0.25*kDia;
kD(12,3) = -0.75*kDia;
kD(9,6) = -0.75*kDia;
kD(12,6) = -0.25*kDia;
kD(12,9) = -0.75*kDia;

end
