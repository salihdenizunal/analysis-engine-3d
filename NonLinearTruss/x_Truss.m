function x = x_Truss(element)

startNodeCoor = element.startNode.coordinates;
endNodeCoor = element.endNode.coordinates;

x =[startNodeCoor(1); endNodeCoor(1); startNodeCoor(2); endNodeCoor(2)];
end
