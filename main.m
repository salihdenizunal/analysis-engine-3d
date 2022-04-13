clear all
clc

n = 100;
mIt = 10;
tol = 1e-3;

fileNames = ["Inputs-10.xlsx","Inputs-100.xlsx","Inputs-1000.xlsx"];
for j = 1:size(fileNames,2)
    fileName = fileNames(j);
    [XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs(fileName);
    
    % Some color options
    switch j
        case 1
            colors{2} = [1, 0, 0];
            requestedDof = 10;
            requestedElements = [9,10]; 
        case 2
            colors{2} = [0, 1, 0];
            requestedDof = 100;
            requestedElements = [99,100]; 
        case 3
            colors{2} = [0, 0, 1];
            requestedDof = 1000;
            requestedElements = [999,1000]; 
    end

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
        
        figure(1)
        plotInternalMomentDiagramAnimation
        pause(1)
        
        figure(2)
        plotGaussPointsMomentDiagramAnimation
        pause(1)
    
        figure(3)
        plotCurvatureAtGaussPointsAnimation
        pause(1)
    
        figure(4)
        plotDisplacement(requestedDof,nodalLoads,f,u,displacementIterations,numberOfIterations,color)
        pause(1)
    
        figure(5)
        plotGaussMomentChangeForTwoElements(requestedElements,elements,moments,n,color)
        pause(1)
    
        figure(6)
        plotInternalMomentChangeForTwoElements(requestedElements,elements,internalForces,n,color)
        pause(1)
    end
end

