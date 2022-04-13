% Change the speed if necessary.
speed = 1000;

clear plotMoments plotData xCoors
set(gca,'Ydir','reverse')
grid on
hold on
yline(0);
yline(elements{1}.McrackPosBending);
yline(elements{1}.McrackNegBending);

gaussLoc = [-1 -0.6546536707079771437983 0 0.6546536707079771437983 1];

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
            xCoors(counter) = startX + (length/2) * (gaussLoc(k) + 1);
            plotMoments(1,counter) = -moments(j,i,k);
            counter = counter + 1;
        end
    end

    % Reset the counter (it is necessary for the animation to clear itself
    % but I dont know why)
    counter = 1;

    % Plot the data and store it in plotData, so that we can delete the
    % previous one to animate the plot.
    plotData(mod(i,2)+1) = plot(xCoors,-plotMoments,'o','Color',color);

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
