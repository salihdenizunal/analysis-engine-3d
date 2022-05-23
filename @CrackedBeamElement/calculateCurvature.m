function curvature = calculateCurvature(this, d)

	% 5 Gauss point Lobatto integration
	Loc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];

	u = this.getElementDisplacements(d);

	for i = 1:5
		Lksi = Loc(i);
		B = this.curvatureDisplacementRelation(Lksi);
		curvature(i) = B * u;
	end

end
