function B = curvatureDisplacementRelation(this, ksi)

	dd_N = this.ddN(ksi);

	B = (4 / this.length^2) * [dd_N(1), dd_N(2), dd_N(3), dd_N(4)];

end
