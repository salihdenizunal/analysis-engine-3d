function updateInertia(this, curvature)

    for i=1:5
        if (curvature(i) ~= 0)
            Mzi = readCurve(this.momentCurvatureCurveInZ, curvature(i));
            EIz = Mzi / curvature(i);
            this.Izeff(i) = EIz / this.elasticityModulus;
        else
            this.Izeff(i) = this.Iz;
        end
    end

end