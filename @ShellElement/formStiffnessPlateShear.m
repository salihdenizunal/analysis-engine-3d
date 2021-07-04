function kPlateShear = formStiffnessPlateShear(this, XY, Loc, Wgt, nGaussShear)
kPlateShear = zeros(12);

for i = 1:nGaussShear
	for j = 1:nGaussShear
		Lksi = Loc(i, nGaussShear);
		Leta = Loc(j, nGaussShear);
		Wksi = Wgt(i, nGaussShear);
		Weta = Wgt(j, nGaussShear);
		
		C = this.formConstitutiveRelationPlateShear();
		J = this.formJacobian(Lksi, Leta, XY);
		B = this.formStrainDisplacementRelationPlate(Lksi, Leta, inv(J));
		
        vi = det(J)*Wksi*Weta;
		
		kPlateShear = kPlateShear + (B' * C * B * vi);
	end
end

end
