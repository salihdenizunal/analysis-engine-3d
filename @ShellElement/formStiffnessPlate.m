function kPlate = formStiffnessPlate(this, XY, Loc, Wgt)

nGaussBending = 2;
nGaussShear = 1;

kBending = this.formStiffnessPlateBending(XY, Loc, Wgt, nGaussBending);
kShear = this.formStiffnessPlateShear(XY, Loc, Wgt, nGaussShear);

kPlate = kBending + kShear;

end
