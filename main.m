clear all
clc

n = 1000;
mIt = 100;
tol = 1e-3;

% fileNames = ["Inputs-10.xlsx"];
fileNames = ["paper1.xlsx"];
for j = 1:size(fileNames,2)
    fileName = fileNames(j);
    [XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs(fileName);
    
    % Colors for different analysis methods.
    colors{1} = [0, 1, 0];
    colors{2} = [1, 0, 0];
    colors{3} = [0, 0, 1];
% 
%     % Inputs-10
%     requestedDof = 10;
%     requestedElements = [9,10];

    % paper1
    requestedDof = 15;
    requestedElements = [5,6];

    % Analysis methods
    for i = 2:2
        [K, elements, nodes] = constructStructure(XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds);
        F = getLoadVector(nodalLoads,nodes);
    
        method = i;
        color = colors{i};
        for elemId = 1:size(elements,2)
		    elements{elemId}.method = i;
        end
    
        tic
        [u,f,inertias,moments,internalForces,numberOfIterations, displacementIterations, curvatures] = solveCrack(elements, K, F, n, mIt, tol);
        toc
        
        disp = nodeDisplacements(nodes, u(:,size(u,2)));
        
%         figure(1)
%         plotInternalMomentDiagramAnimation
%         pause(1)
%         
%         figure(2)
%         plotGaussPointsMomentDiagramAnimation
%         pause(1)
%     
%         figure(3)
%         plotCurvatureAtGaussPointsAnimation
%         pause(1)
%     
        figure(4)
        plotDisplacement(requestedDof,-f*0.1019716213 ,-u*100,-displacementIterations*100,numberOfIterations,color)
        pause(1)
    
%         figure(5)
%         plotGaussMomentChangeForTwoElements(requestedElements,elements,moments,n,color)
%         pause(1)
%     
%         figure(6)
%         plotInternalMomentChangeForTwoElements(requestedElements,elements,internalForces,n,color)
%         pause(1)
    end
end

