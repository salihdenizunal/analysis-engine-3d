fileNames = ["paper2.xlsx", "paper2-experiment.xlsx"];

% paper2-BEAMR6
requestedDof(1) = 29;
requestedDof(2) = 29;

% For files
for j = 2:2
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
        switch solverChoice
            case "NewtonRaphson"
                [u,f,inertias,moments,internalForces,numberOfIterations, displacementIterations, curvatures] = solveNewtonRaphson(elements, K, F, n, mIt, tol);
            case "ArcLength"
                [u, f, internalForces] = solveArcLength(elements, K, F, n, mIt, tol, deltaL, phi);
        end
        toc

        counter = counter + 1;
        color = colors{counter};

        disp = nodeDisplacements(nodes, u(:,size(u,2)));
        
        if plotMomentAnimationFigure
            figure(1)
            plotInternalMomentDiagramAnimation(elements,internalForces,animationSpeed,color, displayName);
            pause(1)
        end
        
        if plotDisplacementFigure
            figure(2)
            xlim([0 5])
            ylim([0 150])
            % converting to kN vs. cm
            plotDisplacement(requestedDof(j), -f, -u*100, color, displayName);
            pause(1)
        end 
    end
end

if plotComparison
    % Load comparison data obtained with grabit
    load('comparison_experiment.mat') % cm kN
    load('comparison_layered_section_approach.mat') % cm kN
    load('comparison_this_study.mat') % cm kN
    load('comparison_larsa_hysteretic_element.mat') % cm kN

    figure(2)
    % cm kN
    plot(comparison_experiment(:,1),comparison_experiment(:,2), 'Color', 'k', 'LineWidth', 3, 'DisplayName', "experiment")
    plot(comparison_layered_section_approach(:,1),comparison_layered_section_approach(:,2), 'Color', 'm', 'LineWidth', 3, 'DisplayName', "layered section approach")
    plot(comparison_this_study(:,1),comparison_this_study(:,2), 'Color', 'c', 'LineWidth', 3, 'DisplayName', "this study(paper2)")
    plot(comparison_larsa_hysteretic_element(:,1),comparison_larsa_hysteretic_element(:,2), 'Color', [0.9500 0.4250 0.3980], 'LineStyle', '--', 'LineWidth', 3, 'DisplayName', "Larsa Hysteretic Element")
end