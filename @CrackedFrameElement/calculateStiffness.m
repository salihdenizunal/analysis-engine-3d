function k = calculateStiffness(this)

    k = zeros(12);
    
    k(1,1) = (this.elasticityModulus * this.area) / this.length;
    k(1,7) = -(this.elasticityModulus * this.area) / this.length;
    
    k(2,2) = (12*this.elasticityModulus*this.Iz) / this.length^3;
    k(2,6) = (6*this.elasticityModulus*this.Iz) / this.length^2;
    k(2,8) = -(12*this.elasticityModulus*this.Iz) / this.length^3;
    k(2,12) = (6*this.elasticityModulus*this.Iz) / this.length^2;
    
    k(3,3) = (12*this.elasticityModulus*this.Iy) / this.length^3;
    k(3,5) = -(6*this.elasticityModulus*this.Iy) / this.length^2;
    k(3,9) = -(12*this.elasticityModulus*this.Iy) / this.length^3;
    k(3,11) = -(6*this.elasticityModulus*this.Iy) / this.length^2;
    
    k(4,4) = (this.shearModulus*this.J) / this.length;
    k(4,10) = -(this.shearModulus*this.J) / this.length;
    
    k(5,3) = k(3,5);
    k(5,5) = (4*this.elasticityModulus*this.Iy) / this.length;
    k(5,9) = (6*this.elasticityModulus*this.Iy) / this.length^2;
    k(5,11) = (2*this.elasticityModulus*this.Iy) / this.length;
    
    k(6,2) = k(2,6);
    k(6,6) = (4*this.elasticityModulus*this.Iz) / this.length;
    k(6,8) = -(6*this.elasticityModulus*this.Iz) / this.length^2;
    k(6,12) = (2*this.elasticityModulus*this.Iz) / this.length;
    
    k(7,1) = k(1,7);
    k(7,7) = ((this.elasticityModulus * this.area) / this.length);
    
    k(8,2) = k(2,8);
    k(8,6) = k(6,8);
    k(8,8) = (12*this.elasticityModulus*this.Iz) / this.length^3;
    k(8,12) = -(6*this.elasticityModulus*this.Iz) / this.length^2;
    
    k(9,3) = k(3,9);
    k(9,5) = k(5,9);
    k(9,9) = (12*this.elasticityModulus*this.Iy) / this.length^3;
    k(9,11) = (6*this.elasticityModulus*this.Iy) / this.length^2;
    
    k(10,4) = k(4,10);
    k(10,10) = (this.shearModulus*this.J) / this.length;
    
    k(11,3) = k(3,11);
    k(11,5) = k(5,11);
    k(11,9) = k(9,11);
    k(11,11) = (4*this.elasticityModulus*this.Iy) / this.length;
    
    k(12,2) = k(2,12);
    k(12,6) = k(6,12);
    k(12,8) = k(8,12);
    k(12,12) = (4*this.elasticityModulus*this.Iz) / this.length;

end