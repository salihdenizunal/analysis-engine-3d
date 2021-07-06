classdef FrameElement
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
        
        % Stifness
        k; % local
        K; % global
        
        % Mass
        m;
        
        % Rotation
        R;
        
        % Equation numbering
        eqnNumbering;
    end
    
    methods 
        function this = FrameElement(id, startNode, endNode, material, section)
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
            
            this.area = section(1);
            this.J = section(2);
            this.Iy = section(3);
            this.Iz = section(4);
            
            this.k = calculateStiffness(this);
            this.R = calculateRotation(this);
            
            this.K = this.R' * this.k * this.R;
        end
        
        k = calculateStiffness(this)
        
        R = calculateRotation(this)
    end
end
