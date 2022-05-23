function ddN = ddN(this, ksi)

    ddN = [1.5 * ksi;
	    0.25 * this.length * (3 * ksi - 1);
	    -1.5 * ksi;
	    0.25 * this.length * (3 * ksi + 1)];
    
end
