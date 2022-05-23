function curvature = calculateCurvature(this, d)

    % 5 Gauss point Lobatto integration
    Loc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];
    
    u = this.getElementDisplacements(d);
    
    % For tangent we only have 4 dof's curvature displacement relation
    u2 = [u(2); 
        u(6); 
        u(8); 
        u(12)];
    
    for i = 1:5
	    Lksi = Loc(i);
	    B = this.curvatureDisplacementRelation(Lksi);
	    curvature(i) = B * u2;
    end

end
