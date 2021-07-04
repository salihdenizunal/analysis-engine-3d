function [r, R] = formRotation(this)

coordinateNodeI = this.nodeI.coordinates;
coordinateNodeJ = this.nodeJ.coordinates;
coordinateNodeK = this.nodeK.coordinates;
coordinateNodeL = this.nodeL.coordinates;

V13 = [coordinateNodeK(1)-coordinateNodeI(1);
    coordinateNodeK(2)-coordinateNodeI(2);
    coordinateNodeK(3)-coordinateNodeI(3)];

V24 = [coordinateNodeL(1)-coordinateNodeJ(1);
    coordinateNodeL(2)-coordinateNodeJ(2);
    coordinateNodeL(3)-coordinateNodeJ(3)];

V3 = cross(V13,V24);

u1 = V13 / norm(V13);
u3 = V3 / norm(V3);
u2 = cross(u3, u1);

r = [u1 u2 u3];
r = r';

for i = 0:7
    j = i*3+1;
    l = j + 2;
    R(j:l,j:l) = r;
end

end
