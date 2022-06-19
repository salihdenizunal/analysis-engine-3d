% Moment vs iteration
function plotGaussMomentChangeForTwoElements(requestedElements, elements, moments, color)
%%
%% USE INTERNAL MOMENT CHANGE INSTEAD OF THIS
%%
    grid on
    hold on
    legend show

    l1 = yline(0);
    l2 = yline(elements{1}.MzcrackNegBending);
    l3 = yline(elements{1}.MzcrackPosBending);
    
    set( get( get( l1, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
    set( get( get( l2, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );
    set( get( get( l3, 'Annotation'), 'LegendInformation' ), 'IconDisplayStyle', 'off' );

    for i = 1:size(moments,2)
        gaussPoint5(i) = -(moments(requestedElements(1),i,5));
        gaussPoint1(i) = -(moments(requestedElements(2),i,1));
    end

    plot(gaussPoint5,'*-','DisplayName',"Element ID = " + int2str(requestedElements(1)) + " Gauss Point = 5",'LineWidth',2, 'Color', color);
    plot(gaussPoint1,'o-','DisplayName',"Element ID = " + int2str(requestedElements(2)) + " Gauss Point = 1",'LineWidth',2, 'Color', color);

end