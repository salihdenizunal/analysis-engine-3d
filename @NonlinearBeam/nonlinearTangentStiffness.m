function Kt = nonlinearTangentStiffness(this, nodalDisplacement)
    
    ln = calculateCurrentLength(this, nodalDisplacement);
    
    N = calculateAxialForceOnBeam(this,ln);
    
    alpha = calculateRigidRotationOfBar(this, ln, nodalDisplacement);
    
    [M1, M2] = calculateBendingMomentsOnBeam(this, alpha, nodalDisplacement);
    
    [s, c] = calculateFinalOrientationAngle(this, ln, nodalDisplacement);
    
    r = calculateSpecialGeometryVector_r(this, s, c);
    
    z = calculateSpecialGeometryVector_z(this, s, c);
    
    A = calculateConncetionMatrixA(this, z, ln);
    
    B = calculateConncetionMatrixB(this, r, A);
    
    C = calculateLocalConstitutiveMatrix(this);
    
    Kt = (B'*C*B + z*z'*N/ln + (r*z'+z*r')*(M1+M2)/(ln^2));
    

end