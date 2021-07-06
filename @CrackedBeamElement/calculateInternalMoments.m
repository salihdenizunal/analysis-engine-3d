function Mi = calculateInternalMoments(this, d)

Loc = [-0.90618 -0.538469 0 0.538469 0.90618];

u = this.getElementDisplacements(d);

for i = 1:5
	Lksi = Loc(i);
	B = this.curvatureDisplacementRelation(Lksi);
	curvature = B * u;
	Mi(i) = curvature * this.Ieff(i) * this.elasticityModulus;
end

end
