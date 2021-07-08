function epsilon = strainTruss(b1, p, length)

A = (1/4).*[1, -1, 0, 0;
            -1, 1, 0, 0;
            0, 0, 1, -1;
            0, 0, -1, 1];
        
epsilon = b1'*p + (p'*A*p)/(2*(length/2)^2);

end