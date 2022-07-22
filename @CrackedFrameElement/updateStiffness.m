function updateStiffness(this, d)

% 1 for TS500
% 2 for moment-curvature relation
% 3 static

if (this.method == 1)
    Mi = this.calculateInternalMoments(d);
    this.updateIeff(Mi);
    this.calculateGlobalTangentStiffness();
elseif (this.method == 2)
    curvature = this.calculateCurvature(d);
    this.updateInertia(curvature);
    this.calculateGlobalTangentStiffness();
elseif (this.method == 3)
    this.Kt = this.K;
    % Don't update, use global stiffness 
end


end
