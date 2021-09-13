function [Kg, elements, nodes] = constructStructure (XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds, thicknesses, strainType)
    
    % Construct node objects
    numNode = size(XYZ, 1);
    [eqnNumbering, numEqn] = getEquaitonNumbering(numNode, supports);
    
    for i = 1:numNode
        globalDofIds = eqnNumbering(i, :);
        coordinates =  XYZ(i, :);
        nodes(i) = Node(i, coordinates, globalDofIds);
    end
    
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

            case 2
                startNode = nodes(connectivity(i,1));
                endNode = nodes(connectivity(i,2));
                material = materials(materialIds(i),:);
                section = sections(sectionIds(i),:);
                elements{i} = FrameElement(i, startNode, endNode, material, section);
            case 3
                nodeI = nodes(connectivity(i,1));
                nodeJ = nodes(connectivity(i,2));
				nodeK = nodes(connectivity(i,3));
                nodeL = nodes(connectivity(i,4));
                material = materials(materialIds(i),:);
				thickness = thicknesses(i);
                elements{i} = ShellElement(i, nodeI, nodeJ, nodeK, nodeL, material, thickness);
            case 5
                startNode = nodes(connectivity(i,1));
                endNode = nodes(connectivity(i,2));
                material = materials(materialIds(i),:);
                section = sections(sectionIds(i),:);
                nodalDisplacements = zeros(numNode, 6);
                elements{i} = NonlinearBeam(i, startNode, endNode, material, section, nodalDisplacements);
        end
    end
    
	Kg = constructGlobalStiffness(elements,numEqn);

end