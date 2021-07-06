function k = calculateStiffness(this)

k = zeros(4);

nGauss = 5;
Loc = [-0.90618 -0.538469 0 0.538469 0.90618];
Wgt = [0.236927 0.478629 0.568889 0.478629 0.236927];

for i = 1:nGauss
	Lksi = Loc(i);
	B = this.curvatureDisplacementRelation(Lksi);
	k = k + B' * B * this.elasticityModulus * this.Ieff(i)  * (this.length / 2) * Wgt(i);
end

end
