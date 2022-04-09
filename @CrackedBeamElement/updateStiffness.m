function updateStiffness(this, d)

% 1 for TS500
% 2 for moment-curvature relation
% 3 static

if (this.method == 1)
    Mi = this.calculateInternalMoments(d);
    this.updateIeff(Mi);
elseif (this.method == 2)
    curvature = this.calculateCurvature(d);
    this.updateInertia(curvature);
elseif (this.method == 3)
    % Don't update stiffness 
end

this.k = this.calculateStiffness();
this.mapCrackedBeamTo3d();
end
