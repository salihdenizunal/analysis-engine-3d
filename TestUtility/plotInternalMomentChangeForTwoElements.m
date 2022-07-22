% Moment vs iteration
function plotInternalMomentChangeForTwoElements(requestedElements, elements, internalForces, color)
    grid on
    hold on
    legend show

    l1 = yline(0);
    l2 = yline(elements{1}.MzcrackNegBending);
    l3 = yline(elements{1}.MzcrackPosBending);
    
    set( get( get( l1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
    set( get( get( l2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
    set( get( get( l3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

    for i = 1:size(internalForces,2)
        elemForce1 = internalForces{requestedElements(1),i};
        moment1(i) = -(elemForce1(2,6));

        elemForce2 = internalForces{requestedElements(2),i};
        moment2(i) = -(elemForce2(2,6));
    end

    plot(moment1,'*-','DisplayName',"Element ID = " + int2str(requestedElements(1)),'LineWidth',2, 'Color', color);
    plot(moment1,'o-','DisplayName',"Element ID = " + int2str(requestedElements(2)),'LineWidth',2, 'Color', color);
end