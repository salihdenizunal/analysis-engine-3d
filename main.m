clear all
clc

n = 1000;
mIt = 100;
tol = 1e-3;

plotMomentAnimationFigure = true;
animationSpeed = 10000;

plotDisplacementFigure = true;
plotComparison = true;

counter = 0;
% Different color options
colors{1} = 'r';                    % red
colors{2} = 'g';                    % green
colors{3} = 'b';                    % blue
colors{4} = [0 0.4470 0.7410];      % dark blue
colors{5} = [0.9500 0.4250 0.3980]; %  dark orange
colors{6} = [0.9290 0.6940 0.1250]; % dark yellow
colors{7} = [0.4940 0.1840 0.5560]; % dark purple
colors{8} = [0.4660 0.6740 0.1880]; % medium green
colors{9} = [0.3010 0.7450 0.9330]; % light blue
colors{10} = 'c';                   % cyan
colors{11} = 'm';                   % magentha
colors{12} = 'k';                   % black

% bransonExperiment
% continuousBeam
% paper1
% paper2
