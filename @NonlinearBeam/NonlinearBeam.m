classdef NonlinearBeam < handle  
properties
    % Element properties
    id (1,1) {mustBePositive, mustBeInteger} = 1;
    startNode;
    endNode;
    length;

    % Material properties
    elasticityModulus;

    % Section properties
    area;
    Iz; % moment of inertia in local z direction
    
    % Stiffness
    K;

    % Equation numbering
    eqnNumbering;
end

methods 
    function this = NonlinearBeam(id, startNode, endNode, material, section, nodalDisplacement)
        this.id = id;
        this.startNode = startNode;
        this.endNode = endNode;

        this.eqnNumbering = [this.startNode.globalDofIds;
                             this.endNode.globalDofIds];

        xDiff = abs(this.startNode.coordinates(1) - this.endNode.coordinates(1));
        yDiff = abs(this.startNode.coordinates(2) - this.endNode.coordinates(2));
        zDiff = abs(this.startNode.coordinates(3) - this.endNode.coordinates(3));

        this.length = sqrt(xDiff^2 + yDiff^2 + zDiff^2);

        this.elasticityModulus = material(1);

        this.area = section(1);
        this.Iz = section(4);
        
        this.K = mapTo3D(this, nonlinearTangentStiffness(this, nodalDisplacement));

    end

    
    K = mapTo3D(this, k1)
    
    k1 = nonlinearTangentStiffness(this, nodalDisplacement)
    
    fi = nonlinearInternalForce(this, nodalDisplacement)
    
    ln = calculateCurrentLength(this, nodalDisplacement)
    
    alpha = calculateRigidRotationOfBar(this, ln, nodalDisplacement)
    
    [s, c] = calculateFinalOrientationAngle(this, ln, nodalDisplacement)
    
    C = calculateLocalConstitutiveMatrix(this)
    
    B = calculateConncetionMatrixB(this, r, A)
    
    A = calculateConncetionMatrixA(this, z, ln)
    
    r = calculateSpecialGeometryVector_r(this, s, c)
    
    z = calculateSpecialGeometryVector_z(this, s, c)
    
    N = calculateAxialForceOnBeam(this, ln)
    
    [M1, M2] = calculateBendingMomentsOnBeam(this, alpha, nodalDisplacement)
    
    updateStiffness(this, nodalDisplacement);
     
end
end
