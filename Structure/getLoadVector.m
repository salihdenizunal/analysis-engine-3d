function F = getLoadVector(nodalLoads, nodes)

    numNode = size(nodes,2);
    numLoadedJoints = size(nodalLoads,1);

    % Initiliaze a load matrix which holds the loads on every node of the
    % structure.
    wholeF = zeros(numNode,6);

    % Assign the loads on the nodes, respectively.
    count = 1;
    for i = 1:numLoadedJoints
        for j = 1:6
            wholeF(nodalLoads(i,1), j) = nodalLoads(i,(j+1));
        end
    end

    % By using the load matrix of the whole structure create the vector which
    % holds the load on the available degrees of freedoms.
    for i = 1:numNode
        node = nodes(i);
        for j = 1:6
            if (node.globalDofIds(j))
                F(count,1) = wholeF(i, j);
                count = count + 1;
            end
        end
    end

end
