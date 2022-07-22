function k = calculateStiffness(this)

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

end
