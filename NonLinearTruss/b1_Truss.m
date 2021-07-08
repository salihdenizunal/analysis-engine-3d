function b1 = b1(element, length)

startNodeCoor = element.startNode.coordinates;
endNodeCoor = element.endNode.coordinates;
b1 = [-(endNodeCoor(1)-startNodeCoor(1)); (endNodeCoor(1)-startNodeCoor(1)); -(endNodeCoor(2)-startNodeCoor(2)); (endNodeCoor(2)-startNodeCoor(2))];
b1 = b1/(4*(length/2)^2);

end
