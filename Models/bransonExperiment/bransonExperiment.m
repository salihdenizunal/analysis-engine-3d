fileNames = ["inputs.xlsx"];
requestedDof(1) = 27;

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
        plotInternalMomentDiagramAnimation(elements,internalForces,n,animationSpeed,color);
        pause(1)

        figure(2)
        xlim([0 2])
        ylim([0 5.5])
        plotDisplacement(requestedDof(j),-f ,-u*1000, color);
        pause(1)
    end
end

% Experiment results
P = [0 3.92 7.84 11.77 15.69 19.61 23.53 27.45 31.38 35.3 39.22 43.14 47.07 50.99 54.91 58.83];
def = [0 0.2 0.38 0.58 0.95 1.67 2.5 3.33 4.13 5.01 5.9 6.73 7.55 8.36 9.17 10.07];

plot(def,P,'DisplayName','Experimental Results','LineWidth',3,'Color','r');
