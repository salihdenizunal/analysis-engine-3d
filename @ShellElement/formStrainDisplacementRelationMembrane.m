function B = formStrainDisplacementRelationMembrane(this, ksi, eta, JI, XY)

MS = [8, 5;
    5, 6;
    6, 7;
    7, 8];

ML =[4;
    1;
    2;
    3];

nL = this.Normal_x_Length(XY);

dNdx = this.dN4_dX(JI, ksi, eta);
dNdy = this.dN4_dY(JI, ksi, eta);
dNSdx = this.dNS_dX(JI, ksi, eta);
dNSdy = this.dNS_dY(JI, ksi, eta);


for i=1:4
    j = (i-1)*3+1;
    k = j+1;
    m = j+2;
    zero = 0;
    B(1,j) = dNdx(i);
    B(2,k) = dNdy(i);
    B(3,j) = dNdy(i);
    B(3,k) = dNdx(i);
    B(1,m) = (dNSdx(MS(i,1),1)*nL(ML(i,1),1) - dNSdx(MS(i,2),1)*nL(i,1))/8;
    B(2,m) = (dNSdy(MS(i,1),1)*nL(ML(i,1),2)- dNSdy(MS(i,2),1)*nL(i,2))/8;
    B(3,m) = (dNSdy(MS(i,1),1)*nL(ML(i,1),1) - dNSdy(MS(i,2),1)*nL(i,1))/8;
    B(3,m) =  B(3, m) + dNSdx(MS(i,1),1)*nL(ML(i,1),2)/8 - dNSdx(MS(i,2),1)*nL(i,2)/8;
end

end

