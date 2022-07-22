function u = getElementDisplacements(this, d)

    u = zeros(12,1);
    idx = 1;
    for i = 1:2
	    for j = 1:6
		    if(this.eqnNumbering(i,j) ~= 0)
			    u(idx) = d(this.eqnNumbering(i,j));
		    end
		    idx = idx + 1;
	    end
    end

end
