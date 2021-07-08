function T = Truss_2D_transformation(cX, Ln)

T = [cX(2) 0 cX(4) 0;
     0 cX(2) 0 cX(4);
     cX(3) 0 cX(2) 0;
     0 cX(3) 0 cX(2)];
 
T = (1/Ln)*T;

end