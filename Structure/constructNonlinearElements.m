function [Kg, elements, nodes] = constructNonlinearElements (XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds, U)
    
    % Construct node objects
    numNode = size(XYZ, 1);
    [eqnNumbering, numEqn] = getEquaitonNumbering(numNode, supports);
    
    
    
    for i = 1:numNode
        globalDofIds = eqnNumbering(i, :);
        coordinates =  XYZ(i, :);
        nodes(i) = Node(i, coordinates, globalDofIds);
    end
    
    nodalDisplacements = getNodalDisplacements(nodes, U);
    
    % Construct element objects
    numElement = size(connectivity, 1);
    for i = 1:numElement
        switch elementTypes(i)
            case 1
                startNode = nodes(connectivity(i,1));
                endNode = nodes(connectivity(i,2));
                material = materials(materialIds(i),:);
                section = sections(sectionIds(i),:);
                elements{i} = TrussElement(i, startNode, endNode, material, section);
            case 4
                startNode = nodes(connectivity(i,1));
                endNode = nodes(connectivity(i,2));
                material = materials(materialIds(i),:);
                section = sections(sectionIds(i),:);
                elements{i} = NonlinearBeam(i, startNode, endNode, material, section, nodalDisplacements);
        end
    end
    
	Kg = constructGlobalStiffness(elements,numEqn);

end