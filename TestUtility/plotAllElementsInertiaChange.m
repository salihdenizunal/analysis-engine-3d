% iteration vs inertia
requestedElements = [1:size(elements,2)];
gaussPoint = 5;

for plotID = 1:size(requestedElements,2)
    elementID = requestedElements(plotID);
    figure
    grid on
    hold on
    legend
    plot(inertias(elementID,:,gaussPoint),'DisplayName',int2str(elementID));
end