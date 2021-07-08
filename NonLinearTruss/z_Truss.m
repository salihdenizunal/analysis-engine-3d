function z = z_Truss(X)

z = [(X(4)-X(3));
    -(X(4)-X(3));
     (X(2)-X(1));
    -(X(2)-X(1))];

end