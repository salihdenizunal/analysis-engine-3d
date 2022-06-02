clear all
clc

n = 1000;
mIt = 100;
tol = 1e-3;

animationSpeed = 10000;

% Different color options
colors{1} = 'r';                    % red
colors{2} = 'g';                    % green
colors{3} = 'b';                    % blue
colors{4} = [0 0.4470 0.7410];      % dark blue
colors{5} = [0.8500 0.3250 0.0980]; %  dark orange
colors{6} = [0.9290 0.6940 0.1250]; % dark yellow
colors{7} = [0.4940 0.1840 0.5560]; % dark purple
colors{8} = [0.4660 0.6740 0.1880]; % medium green
colors{9} = [0.3010 0.7450 0.9330]; % light blue
colors{10} = 'c';                   % cyan
colors{11} = 'm';                   % magentha
colors{12} = 'k';                   % black

% fileNames = ["Inputs-10.xlsx"];
%     % Inputs-10
%     requestedDof = 10;
%     requestedElements = [9,10];


fileNames = ["paper1-frame.xlsx", "paper1-beam.xlsx"];

% paper1-frame
requestedDof(1) = 15;
requestedElements{1} = [5,6];

% paper1-beam
requestedDof(2) = 10;
requestedElements{2} = [5,6];


counter = 0;
for j = 1:1
    
    fileName = fileNames(j);
    [XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs(fileName);
    
    % Analysis methods
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
        
%         figure(1)
%         plotInternalMomentDiagramAnimation(elements,internalForces,n,animationSpeed,color);
%         pause(1)

        figure(2)
        plotDisplacement(requestedDof(j),-f*0.1019716213 ,-u*100,-displacementIterations*100,numberOfIterations,color);
        pause(1)
    end
end
