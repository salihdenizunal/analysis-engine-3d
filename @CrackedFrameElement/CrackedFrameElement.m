classdef CrackedFrameElement < handle
properties
        % Element properties
        id (1,1) {mustBePositive, mustBeInteger} = 1;
        startNode;
        endNode;
        length;
        
        % Material properties
        elasticityModulus;
        poissonsRatio;
        shearModulus;

        % Section properties
        area;
        J; % polar moment of inertia
        Iy; % moment of inertia in local y direction
        Iz; % moment of inertia in local z direction

		Izeff; % Effective moment of inertia of each gauss point in z
		Izcrack; % Cracked section moment of inertia in z
		MzcrackPosBending; % Cracking moment in positive z bending
		MzcrackNegBending; % Cracking moment in negative z bending
        
        momentCurvatureCurveInZ; % moment curvature relation for z bending
        
        % Stifness
        k; % local
        K; % global
        Kt; % tangent
                
        % Rotation
        R;

        % Equation numbering
        eqnNumbering;

        % Method to update stiffness
        method;
    end
    
    methods 
        function this = CrackedFrameElement(id, startNode, endNode, material, section)
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
            this.poissonsRatio = material(2);
            this.shearModulus = this.elasticityModulus / (2 * (1 + this.poissonsRatio));

            this.area = section{1};
            this.J = section{2};
            this.Iy = section{3};
            this.Iz = section{4};

            this.Izcrack = section{5};
            this.MzcrackPosBending = section{6};
            this.MzcrackNegBending = section{7};
            this.momentCurvatureCurveInZ = section{8};

            for i = 1:5
                this.Izeff(i) = this.Iz;
            end
            
            this.k = calculateStiffness(this);
            this.R = calculateRotation(this);
            
            this.K = this.R' * this.k * this.R;
            this.Kt = this.K;
        end
		
		N = N(this, ksi)
		ddN = ddN(this, ksi)			
		B = curvatureDisplacementRelation(this, ksi)
        
        Kt = calculateTangentStiffness(this)
        k = calculateStiffness(this)
        R = calculateRotation(this)
		
		updateStiffness(this,d)
		Mi = calculateInternalMoments(this, d)
		u = getElementDisplacements(this, d)
		updateIeff(this,Mi)
        
        curvature = calculateCurvature(this, d)
		updateInertia(this, curvature)
    end
end
