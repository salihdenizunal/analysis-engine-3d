function T = twist(this, XYZ)

d = (XYZ(1,3) + XYZ(3,3) - XYZ(2,3) - XYZ(4,3)) / 4;

T = eye(24);

T(1, 5) = -d;
T(2, 4) = d;
T(7, 11) = d;
T(8, 10) = -d;
T(13, 17) = -d;
T(14, 16) = d;
T(19, 23) = d;
T(20, 22) = -d;

end
