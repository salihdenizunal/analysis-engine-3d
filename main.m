clear all
clc
grid on
hold on 

[XYZ, supports, connectivity, materials, sections, thickness, elementTypes, materialIds, sectionIds, nodalLoads] = getInputs();
[K, elements, nodes] = constructStructure(XYZ, supports, connectivity, materials, sections, elementTypes, materialIds, sectionIds);
F = getLoadVector(nodalLoads,nodes);

n = 500;
mIt = 500;
tol = 10^-8;
[u,f,inertias] = solveCrack(elements, K, F, n, mIt, tol);



plot(-u(18,:)*1000,-f(4,:)*8,'DisplayName','Nonlinear Analysis Results','LineWidth',3,'Color','b');

% % experiment
P = [0 3.92 7.84 11.77 15.69 19.61 23.53 27.45 31.38 35.30 39.22];
def = [0 0.29 0.65 1.5 2.5 3.68 4.77 6.03 7.31 8.47 9.65];
plot(def,P,'DisplayName','Experimental Results','LineWidth',3,'Color','r');

xlabel('Midspan Deflection, mm');
ylabel('Total Load, kN');

% % inertias
figure
plot(-f(4,:),inertias);