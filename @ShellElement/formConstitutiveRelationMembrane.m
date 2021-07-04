function C = formConstitutiveRelationMembrane(this)

C = [1, this.poissonsRatio, 0;
    this.poissonsRatio, 1, 0;
    0, 0, (1 - this.poissonsRatio)/2];
    
C = (this.elasticityModulus / (1 - this.poissonsRatio^2)) * C;


end
