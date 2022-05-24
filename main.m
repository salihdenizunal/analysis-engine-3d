clear all
clc

n = 1000;
mIt = 100;
tol = 1e-3;

animationSpeed = 10000;

% Different color options
colors{1} = [0, 1, 0];
colors{2} = [1, 0, 0];
colors{3} = [0, 0, 1];

% fileNames = ["Inputs-10.xlsx"];
%     % Inputs-10
%     requestedDof = 10;
%     requestedElements = [9,10];

fileNames = ["paper1-beam.xlsx", "paper1-frame.xlsx"];
% paper1-beam
requestedDof(1) = 10;
requestedElements{1} = [5,6];

% paper1-frame
requestedDof(2) = 15;
requestedElements{2} = [5,6];


for j = 1:size(fileNames,2)
    fileName = fileNames(j);
    [XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs(fileName);
    
    % Analysis methods
    for i = 2:2
        [K, elements, nodes] = constructStructure(XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds);
        F = getLoadVector(nodalLoads,nodes);
    
        method = i;
        for elemId = 1:size(elements,2)
		    elements{elemId}.method = i;
        end
    
        tic
        [u,f,inertias,moments,internalForces,numberOfIterations, displacementIterations, curvatures] = solveCrack(elements, K, F, n, mIt, tol);
        toc
        
        color = colors{j};

        disp = nodeDisplacements(nodes, u(:,size(u,2)));
        
        figure(1)
        plotInternalMomentDiagramAnimation(elements,internalForces,n,animationSpeed,color);
        pause(1)

        figure(2)
        plotDisplacement(requestedDof(j),-f*0.1019716213 ,-u*100,-displacementIterations*100,numberOfIterations,color);
        pause(1)
    end
end

