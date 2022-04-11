% Change the speed if necessary.
speed = 1000;

clear plotCurvatures plotData xCoors

% fh = figure();
grid on
hold on
yline(0);
yline(-max(max(max(curvatures))));
yline(-min(min(min(curvatures))));
% set(gca,'XLim',[0 22],'Ylim',[-10 22]);

increment = [0, 0.3453463292920229, 1, 1.3453463292920229, 2];

gaussLoc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];
% increment = [0, 0.3453/2, 0.6547/2, 0.6547/2, 0.3453/2];

counter = 1;
% For each iteration
for i = 1:n+1
    % For each element
    for j = 1:size(elements,2)
        % Take start x coordinate of the element.
        startX = elements{j}.startNode.coordinates(1);
        length = elements{j}.length;

        % For each gauss point
        for k = 1:5
            % Create the data for plot (xCoor, Corresponding Moment)
            xCoors(counter) = startX + (length/2) * increment(k);
            plotCurvatures(1,counter) = curvatures(j,i,k);
            counter = counter + 1;
        end
    end

    % Reset the counter (it is necessary for the animation to clear itself
    % but I dont know why)
    counter = 1;

    % Plot the data and store it in plotData, so that we can delete the
    % previous one to animate the plot.
    plotData(mod(i,2)+1) = plot(xCoors,-plotCurvatures,'o','Color',color);

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
