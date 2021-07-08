function Kt_3D = make3D_NonLinK(Kt)

Kt_3D = zeros(12);

Kt_3D(1, 1) = Kt(1, 1);
Kt_3D(2, 2) = Kt(3, 3);
Kt_3D(7, 7) = Kt(2, 2);
Kt_3D(8, 8) = Kt(4, 4);
Kt_3D(1, 2) = Kt(1, 3);
Kt_3D(1, 7) = Kt(1, 2);
Kt_3D(1, 8) = Kt(1, 4);
Kt_3D(2, 7) = Kt(3, 2);
Kt_3D(2, 8) = Kt(3, 4);
Kt_3D(2, 1) = Kt(3, 1);
Kt_3D(7, 8) = Kt(2, 4);
Kt_3D(7, 1) = Kt(2, 1);
Kt_3D(7, 2) = Kt(2, 3);
Kt_3D(8, 1) = Kt(4, 1);
Kt_3D(8, 2) = Kt(4, 3);
Kt_3D(8, 7) = Kt(4, 2);

end