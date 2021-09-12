function f = calculateInternalForces(this, d)

u = this.getElementDisplacements(d);
fLocal = this.k * u;

f = zeros(2,6);

if (this.eqnNumbering(1,2) ~= 0) 
    f(1,2) = fLocal(1);
end
if (this.eqnNumbering(1,6) ~= 0) 
    f(1,6) = fLocal(2);
end

if (this.eqnNumbering(2,2) ~= 0) 
    f(2,2) = fLocal(3);
end

if (this.eqnNumbering(2,6) ~= 0) 
    f(2,6) = fLocal(4);
end

end
