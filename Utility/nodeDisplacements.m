function nodeDispSpr = nodeDisplacements(nodes, u)
% nodeDispSpr = zeros(size(nodes,2) + 1 ,size(nodes(1).globalDofIds,2) + 1);

nodeDispSpr{1,1} = "Node ID";
nodeDispSpr{1,2} = "Translation X";
nodeDispSpr{1,3} = "Translation Y";
nodeDispSpr{1,4} = "Translation Z";
nodeDispSpr{1,5} = "Rotation X";
nodeDispSpr{1,6} = "Rotation Y";
nodeDispSpr{1,7} = "Rotation Z";

for i = 1:size(nodes,2)
    
    nodeDispSpr{i+1,1} = nodes(i).id;
    
    for j = 1:size(nodes(1).globalDofIds,2)
        globalID = nodes(i).globalDofIds(j);
        
        if (globalID == 0)
            nodeDispSpr{i+1,j+1} = 0;
        else 
            nodeDispSpr{i+1,j+1} = u(globalID);
        end
    end
    
end
