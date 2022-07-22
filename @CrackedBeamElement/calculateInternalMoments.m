function Mi = calculateInternalMoments(this, d)

    % 5 Gauss point Lobatto integration
    Loc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];

    u = this.getElementDisplacements(d);
    curvature = this.calculateCurvature(d);

    for i = 1:5
        Mi(i) = curvature(i) * (this.elasticityModulus * this.Izeff(i));
    end

end
