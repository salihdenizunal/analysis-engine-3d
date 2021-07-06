function updateStiffness(this, d)

Mi = this.calculateInternalMoments(d);
this.updateIeff(Mi);
this.k = this.calculateStiffness();
this.mapCrackedBeamTo3d();

end