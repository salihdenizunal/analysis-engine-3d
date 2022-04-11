clear all
clc

[XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs();

n = 1000;
mIt = 100;
tol = 1e-10;

% Some color options
colors{1} = [1, 0, 0];
colors{2} = [0, 1, 0];
colors{3} = [0, 0, 1];

for i = 1:3

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
    plotDisplacement(10,nodalLoads,f,u,displacementIterations,numberOfIterations,color)
    pause(1)

    figure(5)
    plotGaussMomentChangeForTwoElements([9,10],elements,moments,n)
    pause(1)

    figure(6)
    plotInternalMomentChangeForTwoElements([9,10],elements,internalForces,n)
    pause(1)
end
