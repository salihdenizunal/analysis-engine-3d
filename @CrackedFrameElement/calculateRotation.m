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