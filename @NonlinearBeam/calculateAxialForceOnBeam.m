function N = calculateAxialForceOnBeam(this, ln)
elasticityModulus = this.elasticityModulus;
area = this.area;

length = this.length;
ut = ((ln^2) - (length^2))/(ln+length);

N = elasticityModulus*area*ut/length;

end