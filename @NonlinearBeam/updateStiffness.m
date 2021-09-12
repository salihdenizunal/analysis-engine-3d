function updateStiffness(this, d)

k1 = this.nonlinearTangentStiffness(d);
this.K = this.mapTo3D(k1);

end