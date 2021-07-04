function [XY, T] = planar(this)

XYZ = [this.nodeI.coordinates;
    this.nodeJ.coordinates;
    this.nodeK.coordinates;
    this.nodeL.coordinates];

xyz = zeros(3,1);
xy = zeros(3,1);
XY = zeros(4,2);
XYz = zeros(4,3);

for ii=1:4
    for j=1:3
        xyz(j) = XYZ(ii,j);
    end
    
    xy = this.r * xyz;
    
    for j=1:2
        XY(ii,j) = xy(j);
    end
    
    for j=1:3
        XYz(ii,j) = xy(j);
    end
end

T = this.twist(XYz);

end
