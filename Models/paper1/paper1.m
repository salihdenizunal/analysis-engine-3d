fileNames = ["frame.xlsx", "beam.xlsx"];

% paper1-frame
requestedDof(1) = 15;

% paper1-beam
requestedDof(2) = 15;

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
        
        if plotMomentAnimationFigure
            figure(1)
            plotInternalMomentDiagramAnimation(elements,internalForces,n,animationSpeed,color, displayName);
            pause(1)
        end

        if plotDisplacementFigure
            figure(2)
            xlim([0 15])
            ylim([0 65])
            % converting to kN vs. mm
            plotDisplacement(requestedDof(j), -f, -u*1000, color, displayName);
            pause(1)
        
            figure(3)
            xlim([0 10/3])
            ylim([0 60/3])
            % converting to kips vs in
            plotDisplacement(requestedDof(j), -f*0.22480894387096, -u*39.3700787, color, displayName);
            pause(1)
        end
    end
end

if plotComparison

    % Comparison data that is used in the paper.
    comparisonData = [
    % cm                   ton
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
    0.0442638295628338	2.69743599149008;
    0.0764976533248962	4.58082679187156;
    0.140965300849022	6.55390286846168;
    0.183943732531773	8.61666422126046;
    0.248411380055899	10.8587961264765;
    0.570749617676528	11.2175372313111;
    0.968300110741970	11.6659636123543;
    1.64521040974529	11.9350194409802;
    2.24690845330380	12.3834458220234;
    2.64445894636924	12.8318722030666;
    3.05275404735537	13.0112427554839;
    3.31062463745188	13.0112427554839;
    3.57923983546907	12.0247047171889;
    4.30987317407583	7.18169980192218;
    4.95454964931709	12.7421869268580;
    ];

    fig9b = [
    % in                kips
    0                   0;
    0.0300173363919188	2.55273213384554;
    0.0702107393344915	4.34617194868818;
    0.110404142277064	6.70053868434328;
    0.123801943257921	8.60718143785328;
    0.204188749143066	10.7356510734261;
    0.418553564836786	11.0640667898746;
    0.887476599166796	11.3828157385268;
    1.27601282761166	11.7046173506936;
    1.82532266782682	12.0203136358311;
    2.18706329430997	12.3431328025028;
    2.56220172177398	12.4410724235970;
    2.78996433844856	12.5446085944681;
    ];

    larsa = [
    % m % kN
    0 0   ;
    0.00029	2	;
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
    % mm kN
    plot(comparisonData(:,1)*10,comparisonData(:,2)*9.8067, 'Color', 'c', 'LineWidth', 3, 'DisplayName', "Comparison Data from Paper 1")
    plot(fig9a(:,1)*25.4,fig9a(:,2)*4.4482216, 'Color', 'k', 'LineWidth', 3, 'DisplayName', "Experimental Data MidSpan")
    plot(fig9b(:,1)*25.4,fig9b(:,2)*4.4482216, 'Color', 'k', 'LineWidth', 3, 'DisplayName', "At Loaded Points")
    plot(larsa(:,1)*1000,larsa(:,2), 'Color', [0.9500 0.4250 0.3980], 'LineWidth', 3, 'DisplayName', "Larsa Hysteretic Element")

    figure(3)
    % in kips
    plot(comparisonData(:,1)*0.393700787,comparisonData(:,2)*2.2046226218, 'Color', 'c', 'LineWidth', 3, 'DisplayName', "Comparison Data from Paper 1")
    plot(fig9a(:,1), fig9a(:,2), 'Color', 'k', 'LineWidth', 3, 'DisplayName', "Experimental Data MidSpan")
    plot(fig9b(:,1), fig9b(:,2), 'Color', 'k', 'LineWidth', 3, 'DisplayName', "At Loaded Points")
    plot(larsa(:,1)*39.3700787,larsa(:,2)*0.22480894387096, 'Color', [0.9500 0.4250 0.3980], 'LineWidth', 3, 'DisplayName', "Larsa Hysteretic Element")
end
