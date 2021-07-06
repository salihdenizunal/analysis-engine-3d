function f = calculateInternalForces(this, d)

u = this.getElementDisplacements(d);
f = this.k * u;

end
