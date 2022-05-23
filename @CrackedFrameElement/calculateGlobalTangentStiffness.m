function Kt = calculateGlobalTangentStiffness(this)

    k = zeros(4);
    
    nGauss = 5;
    
    % % 5 Gauss point Lobatto integration
    Loc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];
    Wgt = [0.1 0.544444444444444444444 0.7111111111111111111111 0.544444444444444444444 0.1];
    
    for i = 1:nGauss
	    Lksi = Loc(i);
	    B = this.curvatureDisplacementRelation(Lksi);
	    k = k + B' * B * this.elasticityModulus * this.Izeff(i)  * (this.length / 2) * Wgt(i);
    end

    kt = this.k;

    kt(2,2) = k(1,1);
    kt(2,6) = k(1,2);
    kt(2,8) = k(1,3);
    kt(2,12) = k(1,4);

    kt(6,2) = k(2,1);
    kt(6,6) = k(2,2);
    kt(6,8) = k(2,3);
    kt(6,12) = k(2,4);
    
    kt(8,2) = k(3,1);
    kt(8,6) = k(3,2);
    kt(8,8) = k(3,3);
    kt(8,12) = k(3,4);
    
    kt(12,2) = k(4,1);
    kt(12,6) = k(4,2);
    kt(12,8) = k(4,3);
    kt(12,12) = k(4,4);
    
    Kt = this.R' * kt * this.R;
    this.Kt = Kt;

end
