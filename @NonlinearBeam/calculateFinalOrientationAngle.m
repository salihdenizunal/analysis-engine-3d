function [s, c] = calculateFinalOrientationAngle(this, ln, nodalDisplacement)
startNodeCoordinate = this.startNode.coordinates;
endNodeCoordinate = this.endNode.coordinates;

startNodeDisp = nodalDisplacement(this.startNode.id, :);
endNodeDisp = nodalDisplacement(this.endNode.id, :);

x21 = [(endNodeCoordinate(1)-startNodeCoordinate(1));
    (endNodeCoordinate(2)-startNodeCoordinate(2))];

d21= [(endNodeDisp(1)-startNodeDisp(1)); 
    (endNodeDisp(2)-startNodeDisp(2))];

s = (x21(2) + d21(2))/ln;

c = (x21(1) + d21(1))/ln;

end