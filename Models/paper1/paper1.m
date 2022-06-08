fileNames = ["frame.xlsx", "beam.xlsx"];

% paper1-frame
requestedDof(1) = 15;

% paper1-beam
requestedDof(2) = 15;

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
        % converting to ton vs. cm
        plotDisplacement(requestedDof(j), -f*0.1019716213, -u*100, color);
        pause(1)
    end
end

% ton / cm
comparisonData = [
0                   0                ;
0.0220197798784853	0.253680831335604;
0.0464101278339561	0.551540728493611;
0.0916315059867697	1.02462477210879;
0.129887337559160	1.41594283533208;
0.185382076798799	1.82481239695247;
0.225261744583423	2.11102307306979;
0.280751016361068	2.51405315179698;
0.310247973818985	2.74768865204495;
0.358700622010283	2.99303947276856;
0.405436487135450	3.24422647141364;
0.450417296960525	3.46037326772772;
0.491909866033394	3.62979759095265;
0.548968299403332	3.86932545364180;
0.590466335938196	4.04458925975994;
0.652768065360431	4.36587979786922;
0.694298906667259	4.57618050134660;
0.794216774608580	4.60556960417399;
0.938929558667178	4.65256308494644;
1.06639796759653	4.67616558442859;
1.17494349056447	4.72308966079433;
1.35410128518560	4.77014924100173];

figure(2)
plot(comparisonData(:,1),comparisonData(:,2), 'Color', k)
