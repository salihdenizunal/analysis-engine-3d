function N = N(this, ksi)

    N = [0.25 * (1 - ksi)^2 * (2 + ksi);
	    0.125 * this.length * (1 - ksi)^2 * (1 + ksi);
	    0.25 * (1 + ksi)^2 * (2 - ksi);
	    -0.125 * this.length * (1 + ksi)^2 * (1 - ksi)];
    
end
