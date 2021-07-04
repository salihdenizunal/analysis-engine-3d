function kMembrane = formStiffnessMembrane(this, XY, Loc, Wgt)
kMembrane = zeros(12);

nGauss = 2;
V = 0;

C = this.formConstitutiveRelationMembrane();

for i = 1:nGauss
    for j = 1:nGauss
        Lksi = Loc(i,nGauss);
        Leta = Loc(j,nGauss);
        Wksi = Wgt(i,nGauss);
        Weta = Wgt(j,nGauss);
        
        J = this.formJacobian(Lksi, Leta, XY);
        B = this.formStrainDisplacementRelationMembrane(Lksi, Leta, inv(J), XY);
        
        vi = this.thickness * det(J)*Wksi*Weta;
        
        kMembrane = kMembrane + (B' * C * B * vi);
        V = V + vi;
    end
end

ks = this.addDrilling(V);
kMembrane = kMembrane + ks;

end
