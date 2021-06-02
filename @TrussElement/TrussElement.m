classdef TrussElement
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
        function this = TrussElement(id, startNode, endNode, material, section)
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
            
            
            this.k = calculateStiffness(this);
            this.R = calculateRotation(this);
            
            this.K = this.R' * this.k * this.R;
        end
        
        function k = calculateStiffness(this)
            k = zeros(12);
            
            k(1,1) = ((this.elasticityModulus * this.area) / this.length);
            k(1,7) = -((this.elasticityModulus * this.area) / this.length);
            
            k(7,1) = k(1,7);
            k(7,7) = ((this.elasticityModulus * this.area) / this.length);
        end
        
        function R = calculateRotation(this)
            rollAngle = 0;
            
            thetaxX = (this.endNode.coordinates(1) - this.startNode.coordinates(1)) / this.length;
            thetaxY = (this.endNode.coordinates(2) - this.startNode.coordinates(2)) / this.length;
            thetaxZ = (this.endNode.coordinates(3) - this.startNode.coordinates(3)) / this.length;
            
            r(1,1) = thetaxX;
            r(1,2) = thetaxY;
            r(1,3) = thetaxZ;
            
            r(2,1) = (-thetaxX*thetaxY - thetaxZ * sin(rollAngle)) / sqrt(thetaxX^2 + thetaxZ^2);
            r(2,2) = sqrt(thetaxX^2 + thetaxZ^2) * cos(rollAngle);
            r(2,3) = (-thetaxY*thetaxZ*cos(rollAngle) + thetaxX * sin(rollAngle)) / sqrt(thetaxX^2 + thetaxZ^2);
            
            r(3,1) = (thetaxX*thetaxY - thetaxZ*cos(rollAngle)) / sqrt(thetaxX^2 + thetaxZ^2);
            r(3,2) = -sqrt(thetaxX^2 + thetaxZ^2)*sin(rollAngle);
            r(3,3) = (thetaxY*thetaxZ*sin(rollAngle) + thetaxX*cos(rollAngle)) / sqrt(thetaxX^2 + thetaxZ^2);
            
            R = zeros(12);
            for i=0:3
                startIdx = 3*i + 1;
                endIdx = startIdx + 2;
                R(startIdx:endIdx,startIdx:endIdx) = r;
            end
        end
    end
end
