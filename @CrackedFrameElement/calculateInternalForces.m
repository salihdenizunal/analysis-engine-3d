function f = calculateInternalForces(this, d, tangent)

    u = this.getElementDisplacements(d);
    
    if (tangent)
        force = this.Kt * u;
    else
        force = this.K * u;
    end
    
    f(1,1:6) = force(1:6);
    f(2,1:6) = force(7:12);

end
