function updateInertia(this, curvature)



for i=1:5
    if (curvature(i) ~= 0)
        Mi = readCurve(this.momentCurvatureCurve, curvature(i));
        EI = Mi / curvature(i);
    else
        EI = this.momentCurvatureCurve(25,2)/this.momentCurvatureCurve(25,1);
    end

    this.Ieff(i) = EI / this.elasticityModulus;
end

end