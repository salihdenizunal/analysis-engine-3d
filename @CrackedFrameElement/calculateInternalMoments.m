function Mi = calculateInternalMoments(this, d)

    curvature = this.calculateCurvature(d);
    
    for i = 1:5
        Mi(i) = curvature(i) * (this.elasticityModulus * this.Izeff(i));
    end

end
