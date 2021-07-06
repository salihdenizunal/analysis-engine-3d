function C = formConstitutiveRelationPlateBending(this)

C = [1.0, this.poissonsRatio, 0.0;
	this.poissonsRatio, 1.0, 0.0;
	0.0, 0.0, (1.0 - this.poissonsRatio) / 2.0];

C = (((this.elasticityModulus*this.thickness^3)) / (12.0 * (1.0 - this.poissonsRatio^2))) * C;

end
