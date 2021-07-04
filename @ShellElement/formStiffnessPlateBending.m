function kPlateBending = formStiffnessPlateBending(this, XY, Loc, Wgt, nGaussBending)
kPlateBending = zeros(12);

for i = 1:nGaussBending
	for j = 1:nGaussBending
		Lksi = Loc(i, nGaussBending);
		Leta = Loc(j, nGaussBending);
		Wksi = Wgt(i, nGaussBending);
		Weta = Wgt(j, nGaussBending);
		
		C = this.formConstitutiveRelationPlateBending();
		J = this.formJacobian(Lksi, Leta, XY);
		B = this.formCurvatureDisplacementRelationPlate(Lksi, Leta, inv(J));
		
        vi = det(J)*Wksi*Weta;
		
		kPlateBending = kPlateBending + (B' * C * B * vi);
	end
end

end
