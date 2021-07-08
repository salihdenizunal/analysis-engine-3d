function internalForceTruss = internalForceTruss(UT, elements, nodes, elementTypes, numDof)

internalForceTruss = zeros(numDof, 1);

nodalDisplacement = getNodalDisplacements(nodes, UT);
numElement = size(elements, 2);
for i = 1:numElement
    q(:,i) = zeros(12, 1);
    
    element = elements(i);
    element = element{1};
    
    startNodeDofIds = element.startNode.globalDofIds;
    endNodeDofIds = element.endNode.globalDofIds;
    
    length = element.length;
    area = element.area;
    
    if elementTypes(element.id) ~= 1
        throw(MException('MyComponent:noSuchVariable','There should be only truss elements!'));
    end
    
    b1 = b1_Truss(element, length);
    
    b2p = b2p_Truss(element, nodalDisplacement, length);
    
    p = p_Truss(element, nodalDisplacement);
    
    epsilon = strainTruss(b1, p, length);
    
    sigmaG = element.elasticityModulus * epsilon;
    
    q_dummy(:,i) = length*area*sigmaG*(b1 + b2p);
    
    q(1,i) = q_dummy(1,i);
    q(7,i) = q_dummy(2,i);
    q(2,i) = q_dummy(3,i);
    q(8,i) = q_dummy(4,i);
    
    for j = 1:size(startNodeDofIds, 2)
        if startNodeDofIds(j) ~= 0
            internalForceTruss(startNodeDofIds(j)) = internalForceTruss(startNodeDofIds(j)) + q(j,i);
        end
    end
    for j = 1:size(endNodeDofIds, 2)
        if endNodeDofIds(j) ~= 0
            internalForceTruss(endNodeDofIds(j)) = internalForceTruss(endNodeDofIds(j)) + q(j+6,i);
        end
    end
    
end
end