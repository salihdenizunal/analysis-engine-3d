function C = formConstitutiveRelationPlateShear(this)

C(1, 1) = (5.0 / 12.0) * ((this.elasticityModulus*this.thickness) / (1.0 + this.poissonsRatio));
C(2, 2) = C(1, 1);

end
