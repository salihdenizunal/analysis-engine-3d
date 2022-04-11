function plotDisplacement(requestedDof,nodalLoads,f,u,displacementIterations,numberOfIterations,color)

grid on
hold on 
plot(u(requestedDof,:),f(requestedDof,:)*(size(nodalLoads,1)));


forces = zeros(1);
for j=1:size(f,2)
    for i=1:numberOfIterations(j)
        forces(end+1) = f(requestedDof,j)*(size(nodalLoads,1));
    end
end

plot(displacementIterations(requestedDof,:),forces,'Color',color);
legend
end