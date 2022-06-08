function plotDisplacement(requestedDof,f,u,color)

    grid on
    hold on
    
    totalForceIterations = sum(f,1);
    plot(u(requestedDof,:),totalForceIterations,'Color',color);
    xlabel('Displacement');
    ylabel('Load');

end
