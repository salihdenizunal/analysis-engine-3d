function updateInertia(this, curvature)

    for i = 1:5
        if (curvature(i) ~= 0)
            Mi = readCurve(this.momentCurvatureCurve, curvature(i));
            EI = Mi / curvature(i);
            this.Izeff(i) = EI / this.elasticityModulus;
        else
            this.Izeff(i) = this.Iz;
        end
    end

end
