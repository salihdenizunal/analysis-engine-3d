function b2p = b2p_Truss(element, nodalDisplacement, length)

startNodeID = element.startNode.id;
endNodeID = element.endNode.id;
startDisplacement = nodalDisplacement(startNodeID, :);
endDisplacement = nodalDisplacement(endNodeID, :);
b2p = [-(endDisplacement(1)-startDisplacement(1)); (endDisplacement(1)-startDisplacement(1)); -(endDisplacement(2)-startDisplacement(2)); (endDisplacement(2)-startDisplacement(2))];
b2p = b2p/(4*(length/2)^2);

end