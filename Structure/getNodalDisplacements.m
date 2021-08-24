function nodalDisplacements = getNodalDisplacements(nodes, u)

numNodes = size(nodes, 2);
nodalDisplacements = zeros(numNodes, 6);

for i = 1:numNodes
    node = nodes(i);
    numDofAtNode = size(node.globalDofIds, 2);
    for j =1:numDofAtNode
        if node.globalDofIds(j) ~= 0
            nodalDisplacements(i,j) = u(node.globalDofIds(j));
        end      
    end
end

end