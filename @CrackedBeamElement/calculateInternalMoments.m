function Mi = calculateInternalMoments(this, d)

% % 5 Gauss point integration
% Loc = [-0.90618 -0.538469 0 0.538469 0.90618];

% 5 Gauss point Lobatto integration
Loc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];

u = this.getElementDisplacements(d);
curvature = this.calculateCurvature(d);

for i = 1:5
    Mi(i) = readCurve(this.momentCurvatureCurve, curvature(i));
end

end
