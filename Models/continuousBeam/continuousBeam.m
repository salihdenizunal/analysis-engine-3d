fileNames = ["10 elements.xlsx", "100 elements.xlsx"];

% 10 Elements
requestedDof(1) = 15;

% 100 Elements
requestedDof(2) = 150;

counter = 0;
% For files
for j = 1:1
    fileName = fileNames(j);
    [XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs(fileName);
    
    % Analysis methods
    % 1 for TS500
    % 2 for moment-curvature relation
    % 3 static
    for i = 1:3
        displayName = "file: " + fileName + " Analysis method: ";
        switch i
            case 1
                displayName = displayName + "Branson";
            case 2
                displayName = displayName + "Moment Curvature Relation";
            case 3
                displayName = displayName + "Linear Static";
        end

        [K, elements, nodes] = constructStructure(XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds);
        F = getLoadVector(nodalLoads,nodes);
    
        method = i;
        for elemId = 1:size(elements,2)
		    elements{elemId}.method = i;
        end
    
        tic
        [u,f,inertias,moments,internalForces,numberOfIterations, displacementIterations, curvatures] = solveCrack(elements, K, F, n, mIt, tol);
        toc

        counter = counter + 1;
        color = colors{counter};

        disp = nodeDisplacements(nodes, u(:,size(u,2)));

        figure(1)
        plotInternalMomentDiagramAnimation(elements,internalForces,n,animationSpeed,color, displayName);
        pause(1)

        figure(2)
        xlim([0 1.5*10^-3])
        ylim([0 400])
        plotDisplacement(requestedDof(j),-f ,-u, color, displayName);
        pause(1)
    end
end
