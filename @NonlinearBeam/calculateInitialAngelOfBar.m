function beta0 = calculateInitialAngelOfBar(this)
startNodeCoordinate = this.startNode.coordinates;
endNodeCoordinate = this.endNode.coordinates;


beta0 = atan2((endNodeCoordinate(2)-startNodeCoordinate(2)),(endNodeCoordinate(1)-startNodeCoordinate(1)));

end