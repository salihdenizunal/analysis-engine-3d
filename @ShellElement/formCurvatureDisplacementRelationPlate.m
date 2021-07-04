function B = formCurvatureDisplacementRelationPlate(this, ksi, eta, JI)
dDx = this.dN4_dX(JI, ksi, eta);
dDy = this.dN4_dY(JI, ksi, eta);

for i = 0:3
	j = 3 * i + 2;
	k = j + 1;
	
	B(1,k) = -dDx(i+1);
	B(2,j) = dDy(i+1);
	B(3,j) = -B(1,k);
	B(3,k) = -B(2,j);
end

end
