function fi = nonlinearInternalForce(this, nodalDisplacement)

    ln = calculateCurrentLength(this, nodalDisplacement);
    
    N = calculateAxialForceOnBeam(this,ln);
    
    beta0 = calculateInitialAngelOfBar(this);
    
    [s, c] = calculateFinalOrientationAngle(this, ln, nodalDisplacement);
    
    [M1, M2] = calculateBendingMomentsOnBeam(this, beta0, nodalDisplacement, s, c);
    
    r = calculateSpecialGeometryVector_r(this, s, c);
    
    z = calculateSpecialGeometryVector_z(this, s, c);
    
    A = calculateConncetionMatrixA(this, z, ln);
    
    B = calculateConncetionMatrixB(this, r, A);
    
    fil = [N; M1; M2];
    
    fi = (B')*fil;
    
end