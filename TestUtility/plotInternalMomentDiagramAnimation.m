function plotInternalMomentDiagramAnimation(elements,internalForces,n,speed,color)
    
    clear plotMoments plotData xCoors
    set(gca,'Ydir','reverse')
    grid on
    hold on
    yline(0);
    
    yMin = 0;
    yMax = 0;
    % For each iteration
    for i = 1:n+1
        xMin = elements{1}.startNode.coordinates(1);
        xMax = elements{size(elements,2)}.endNode.coordinates(1);
        xlim([xMin, xMax]);

        % For each element
        for j = 1:size(elements,2)
            if (internalForces{j,i}(1,6) > yMax), yMax = internalForces{j,i}(1,6); end
            if (internalForces{j,i}(1,6) < yMin), yMin = internalForces{j,i}(1,6); end
        end
    end
    ylim([-yMax, -yMin]);

    counter = 1;
    % For each iteration
    for i = 1:n+1
        % For each element
        for j = 1:size(elements,2)
            % Take start and end x coordinates.
            startX = elements{j}.startNode.coordinates(1);
            endX = elements{j}.endNode.coordinates(1);
    
            % Create the data for plot (xCoor, Corresponding Moment)
            xCoors(counter) = startX;
            plotMoments(1,counter) = internalForces{j,i}(1,6);
            counter = counter + 1;
    
            xCoors(counter) = endX;
            plotMoments(1,counter) = -internalForces{j,i}(2,6);
            counter = counter + 1;
        end

        % Reset the counter (it is necessary for the animation to clear itself
        % but I dont know why)
        counter = 1;
    
        % Plot the data and store it in plotData, so that we can delete the
        % previous one to animate the plot.
        plotData(mod(i,2)+1) = plot(xCoors,-plotMoments,'*-','LineWidth',2,'Color',color);
    
        % Some color options
        % [255/255, 229/255, 16/255] - yellow
    
        % After the first iteration, clear the previous plot. For a continuous
        % animation we store 2 plot data at the same time.
        if (i ~= 1)
            if(mod(i,2) == 0)
                delete(plotData(2));
            else  
                delete(plotData(1));
            end
        end
    
        % Pause for a bit, again for animation.
        pause(1/speed);
    end

end
