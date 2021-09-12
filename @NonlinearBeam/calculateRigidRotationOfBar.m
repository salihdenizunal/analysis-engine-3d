function alpha = calculateRigidRotationOfBar(this, ln, nodalDisplacement)
length = this.length;

startNodeCoordinate = this.startNode.coordinates;
endNodeCoordinate = this.endNode.coordinates;

startNodeDisp = nodalDisplacement(this.startNode.id, :);
endNodeDisp = nodalDisplacement(this.endNode.id, :);

x21 = [(endNodeCoordinate(1)-startNodeCoordinate(1));
    (endNodeCoordinate(2)-startNodeCoordinate(2))];

d21= [(endNodeDisp(1)-startNodeDisp(1)); 
    (endNodeDisp(2)-startNodeDisp(2))];

sinA = (x21(1)*d21(2) - x21(2)*d21(1))/(length*ln);

cosA = x21'*(x21+d21)/(length*ln);

if (((sinA >= 0) & (cosA >=0)) | ((sinA <= 0) & (cosA >=0)))
    
    alpha = asin(sinA);

elseif((sinA >= 0) & (cosA <=0))
    
    alpha = acos(cosA);
    
elseif((sinA <= 0) & (cosA <=0))
    
    alpha = -acos(cosA);
    
end

end