function updateStiffness(this, d)

% 1 for TS500
% 2 for moment-curvature relation
% 3 static

method = 2;

if (method == 1)
    Mi = this.calculateInternalMoments(d);
    this.updateIeff(Mi);
elseif (method == 2)
    curvature = this.calculateCurvature(d);
    this.updateInertia(curvature);
elseif (method == 3)
    
end

this.k = this.calculateStiffness();
this.mapCrackedBeamTo3d();
end
