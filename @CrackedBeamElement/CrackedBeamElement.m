classdef CrackedBeamElement < handle
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
        Iz; % Gross section moment of inertia
		Izeff; % Effective moment of inertia of each gauss point
		Izcrack; % Cracked section moment of inertia
		MzcrackPosBending; % Cracking moment in positive bending
		MzcrackNegBending; % Cracking moment in negative bending
        
        momentCurvatureCurve;
        
        % Stifness
        k; % local
        K; % global
        Kt; % tangent
        
        % Equation numbering
        eqnNumbering;

        % Method to update stiffness
        method;
    end
    
    methods 
        function this = CrackedBeamElement(id, startNode, endNode, material, section)
            this.id = id;
            this.startNode = startNode;
            this.endNode = endNode;
            
            this.eqnNumbering = [this.startNode.globalDofIds;
				this.endNode.globalDofIds];
            
            xDiff = abs(this.startNode.coordinates(1) - this.endNode.coordinates(1));
            yDiff = abs(this.startNode.coordinates(2) - this.endNode.coordinates(2));
            zDiff = 0;
            
            this.length = sqrt(xDiff^2 + yDiff^2 + zDiff^2);
            
            this.elasticityModulus = material(1);
            
            this.area = section{1};
            this.Iz = section{4};
            this.Izcrack = section{5};
            this.MzcrackPosBending = section{6};
            this.MzcrackNegBending = section{7};
            this.momentCurvatureCurve = section{8};

            for i = 1:5
                this.Izeff(i) = this.Iz;
            end
            
            this.k = calculateStiffness(this);
            mapCrackedBeamTo3d(this);
		end
		
		N = N(this, ksi)
		ddN = ddN(this, ksi)			
		B = curvatureDisplacementRelation(this, ksi)
        k = calculateStiffness(this)
		mapCrackedBeamTo3d(this)
		
		updateStiffness(this,d)
		Mi = calculateInternalMoments(this, d)
		u = getElementDisplacements(this, d)
		updateIeff(this,Ma)
        
        curvature = calculateCurvature(this, d)
		updateInertia(this, curvature)
    end
end
