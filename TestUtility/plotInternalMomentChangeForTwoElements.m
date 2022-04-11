% Moment vs iteration
function plotInternalMomentChangeForTwoElements(requestedElements, elements, internalForces, n)
    grid on
    hold on
    legend show

    l1 = yline(0);
    l2 = yline(elements{1}.McrackNegBending);
    l3 = yline(elements{1}.McrackPosBending);
    
    set( get( get( l1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
    set( get( get( l2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
    set( get( get( l3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

    for i = 1:(n+1)
        elemForce1 = internalForces{requestedElements(1),i};
        moment1(i) = -(elemForce1(2,6));

        elemForce2 = internalForces{requestedElements(2),i};
        moment2(i) = -(elemForce2(2,6));
    end

    plot(moment1,'DisplayName',"Element ID = " + int2str(requestedElements(1)),'LineWidth',2);
    plot(moment1,'DisplayName',"Element ID = " + int2str(requestedElements(2)),'LineWidth',2);

end