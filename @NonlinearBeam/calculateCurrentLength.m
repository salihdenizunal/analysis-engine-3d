function ln = calculateCurrentLength(this, nodalDisplacement)
startNodeCoordinate = this.startNode.coordinates;
endNodeCoordinate = this.endNode.coordinates;

startNodeDisp = nodalDisplacement(this.startNode.id, :);
endNodeDisp = nodalDisplacement(this.endNode.id, :);

x21 = [(endNodeCoordinate(1)-startNodeCoordinate(1));
    (endNodeCoordinate(2)-startNodeCoordinate(2))];

d21= [(endNodeDisp(1)-startNodeDisp(1)); 
    (endNodeDisp(2)-startNodeDisp(2))];

ln = sqrt((x21+d21)'*(x21+d21));

end