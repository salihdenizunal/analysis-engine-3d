function Normal_x_Length = Normal_x_Length(this, XY)

JK = [1,2;
    2,3;
    3,4;
    4,1];

nE = size(XY, 1);

for i = 1:nE    
    JK1 = JK(i,1);
    JK2 = JK(i,2);
    Normal_x_Length(i,1) = XY(JK2,2) - XY(JK1,2);
    Normal_x_Length(i,2) = -(XY(JK2,1) - XY(JK1,1));
end

end
