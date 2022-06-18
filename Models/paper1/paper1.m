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
        xlim([0 15])
        ylim([0 65])
        % converting to -- vs. mm
        plotDisplacement(requestedDof(j), -f, -u*1000, color);
        pause(1)
    end
end

% ton / cm
% Comparison data that is used in the paper.
comparisonData = [
0                      0;
0.0220197798784853     0.253680831335604;
0.0464101278339561     0.551540728493611;
0.0916315059867697     1.02462477210879;
0.129887337559160      1.41594283533208;
0.185382076798799      1.82481239695247;
0.225261744583423      2.11102307306979;
0.280751016361068      2.51405315179698;
0.310247973818985      2.74768865204495;
0.358700622010283      2.99303947276856;
0.405436487135450      3.24422647141364;
0.450417296960525      3.46037326772772;
0.491909866033394      3.62979759095265;
0.548968299403332      3.86932545364180;
0.590466335938196      4.04458925975994;
0.652768065360431      4.36587979786922;
0.694298906667259      4.57618050134660;
0.794216774608580      4.60556960417399;
0.938929558667178      4.65256308494644;
1.06639796759653       4.67616558442859;
1.17494349056447       4.72308966079433;
1.35410128518560       4.77014924100173;
];

% Experimental results of T1Ma from the original paper.
fig9a = [
% in                kips
0                   0;
0.0526244787941833	2.62889385741070;
0.0760404498042828	4.46650161346752;
0.137404583389759	6.38337586897130;
0.189244604414133	8.50019582512091;
0.250561555559462	10.6967675858161;
0.558945984360288	11.0111644055614;
0.966946025008627	11.5236465897410;
1.62647565408065	11.8320579799362;
2.23855322906197	12.1412782119625;
2.63231765348310	12.6540030486914;
3.04514378372362	12.6869229112168;
3.29187424394949	12.8025872930629;
3.56726466639037	11.7989763490446;
4.27985431958200	6.99202934686767;
4.94326638944326	12.4148285192376;
];

fig9b = [
% in                kips
0                   0;
0.0548308465383811	2.72923641658760;
0.0772572718307561	4.30322171226718;
0.107129842254538	6.48757093397669;
0.140851970722622	8.60751155023641;
0.189928336418835	10.5983709859021;
0.442437346650493	10.9110430889975;
0.886313386633027	11.2492542600326;
1.27277601806912	11.5894452037762;
1.83526244076522	12.0521180857522;
2.17201077974348	12.2654715913047;
2.54705672189389	12.4132286277822;
2.78435447848192	12.4371838775551;
];

larsa = [
% m % kN0.00029	2	;
0.00057	4	;
0.00086	6	;
0.00114	8	;
0.00143	10	;
0.00172	12	;
0.002	14	;
0.00229	16	;
0.00257	18	;
0.00286	20	;
0.00315	22	;
0.00343	24	;
0.00372	26	;
0.004	28	;
0.00429	30	;
0.00473	32	;
0.00524	34	;
0.00576	36	;
0.00631	38	;
0.00685	40	;
0.0074	42	;
0.00796	44	;
0.00802	44.2	;
0.00811	44.52	;
0.00826	45.06	;
0.00828	45.14	;
0.01035	45.28	;
0.01376	45.76	;
0.01859	46.14	;
0.02542	46.66	;
0.03224	47.16	;
0.03908	47.02	;
0.0459	47.32	;
0.05273	47.34	;
0.05955	47.48	;
0.06638	47.26	;
0.06706	47.26	;
0.06817	47.24	;
0.06999	47.26	;
0.07029	47.28	;
0.07077	47.3	;
0.07156	47.34	;
0.07169	47.34	;
0.0719	47.34	;
0.07194	47.34	;
0.07199	47.34	;
0.07209	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;
0.07224	47.36	;

];

figure(2)
%               mm              kN
plot(comparisonData(:,1)*10,comparisonData(:,2)*9.8067, 'Color', 'c')
%               mm              kN
plot(fig9a(:,1)*25.4,fig9a(:,2)*4.4482216, 'Color', 'k')
%               mm              kN
plot(fig9b(:,1)*25.4,fig9b(:,2)*4.4482216, 'Color', 'k')
%               mm              kN
plot(larsa(:,1)*1000,larsa(:,2), 'Color', [0.8500 0.3250 0.0980])