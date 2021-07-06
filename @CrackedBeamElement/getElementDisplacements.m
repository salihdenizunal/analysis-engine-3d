function u = getElementDisplacements(this, d)

u = zeros(4,1);

realDofs = [ this.eqnNumbering(1,2), this.eqnNumbering(1,6);
	this.eqnNumbering(2,2), this.eqnNumbering(2,6)];

idx = 1;
for i = 1:2
	for j = 1:2
		if(realDofs(i,j) ~= 0)
			u(idx) = d(realDofs(i,j));
		end
		idx = idx + 1;
	end
end

end
