function Mi = calculateInternalMoments(this, d)

% % 5 Gauss point integration
% Loc = [-0.90618 -0.538469 0 0.538469 0.90618];

% 5 Gauss point Lobatto integration
Loc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];

u = this.getElementDisplacements(d);

for i = 1:5
	Lksi = Loc(i);
	B = this.curvatureDisplacementRelation(Lksi);
	curvature = B * u;
	Mi(i) = curvature * this.Ieff(i) * this.elasticityModulus;
end

end
