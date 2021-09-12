function C = calculateLocalConstitutiveMatrix(this)
elasticityModulus = this.elasticityModulus;
area = this.area;
length = this.length;
Iz = this.Iz;
r = sqrt(Iz/area);

C =[1, 0 ,0; 
    0, (4*r^2), (2*r^2); 
    0, (2*r^2), (4*r^2)];

C = C*elasticityModulus*area/length;
end