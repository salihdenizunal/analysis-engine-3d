function p = p_Truss(element, nodalDisplacement)

startNodeID = element.startNode.id;
endNodeID = element.endNode.id;
startDisplacement = nodalDisplacement(startNodeID, :);
endDisplacement = nodalDisplacement(endNodeID, :);

p =[startDisplacement(1); endDisplacement(1); startDisplacement(2); endDisplacement(2)];
end