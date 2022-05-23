function f = calculateInternalForces(this, d, tangent)

    u = this.getElementDisplacements(d);
    
    % TODO: Change here to use tangent stiffness
    if (tangent)
        fLocal = this.k * u;
    else
        fLocal = this.k * u;
    end

    f = zeros(2,6);

    if (this.eqnNumbering(1,2) ~= 0) 
        f(1,2) = fLocal(1);
    end
    if (this.eqnNumbering(1,6) ~= 0) 
        f(1,6) = fLocal(2);
    end

    if (this.eqnNumbering(2,2) ~= 0) 
        f(2,2) = fLocal(3);
    end

    if (this.eqnNumbering(2,6) ~= 0) 
        f(2,6) = fLocal(4);
    end

end
