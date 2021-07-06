function B = formStrainDisplacementRelationPlate(this, ksi, eta, JI)
dDx = this.dN4_dX(JI, ksi, eta);
dDy = this.dN4_dY(JI, ksi, eta);
N = this.N4(ksi, eta);

for i = 0:3
	ii = 3 * i + 1;
	j = ii + 1;
	k = j + 1;

	B(2,ii) = -dDy(i+1);
	B(1,ii) = dDx(i+1);
	B(1,k) = N(i+1);
	B(2,j) = N(i+1);
end

end
