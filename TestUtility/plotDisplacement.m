function plotDisplacement(requestedDof,f,u,displacementIterations,numberOfIterations,color)

grid on
hold on 

xlim([0 2])
ylim([0 5.5])

totalForceIterations = sum(f,1);
plot(u(requestedDof,:),totalForceIterations);


forces = zeros(1);
for j=1:size(f,2)
    for i=1:numberOfIterations(j)
        forces(end+1) = totalForceIterations(j);
    end
end

plot(displacementIterations(requestedDof,:),forces,'Color',color);
legend
end