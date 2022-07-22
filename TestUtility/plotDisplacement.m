function plotDisplacement(requestedDof,f,u,color,displayName)

    grid on
    hold on
    legend

    totalForceIterations = sum(f,1);
    plot(u(requestedDof,:),totalForceIterations,'Color',color, 'LineWidth', 3, 'DisplayName', displayName);
    xlabel('Displacement');
    ylabel('Load');

end
