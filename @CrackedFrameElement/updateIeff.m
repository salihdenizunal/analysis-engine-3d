function updateIeff(this, Mi)
    
%% For gauss points
%     for i=1:5
%         % If Mi(i) == 0, the inertia will be calculated as NaN. Since it is not
%         % smaller than the gross section moment of inertia, that case will be
%         % handled in the following control statement.
%         if (Mi(i) > 0)
%             Mcrack = this.MzcrackPosBending;
%         else
%             Mcrack = this.MzcrackNegBending;
%         end
%     
%         inertiaZ = (Mcrack / Mi(i))^3 * this.Iz + (1 - (Mcrack / Mi(i))^3) * this.Izcrack;
%     
%         % Effective moment of ineartia of the element at a gauss point.
%         % But not greater than gross section moment of inertia.
%         if (inertiaZ <= this.Iz)
%             if (inertiaZ < this.Izcrack)
%                 this.Izeff(i) = this.Izcrack;
%             else
%                 this.Izeff(i) = inertiaZ;
%             end
%         else
%             this.Izeff(i) = this.Iz;
%         end
%     end

%% Element-wise 
    
    % Find max moment in this section.
    Ma = 0;
    for i = 1:5
        if (abs(Mi(i)) > Ma)
            Ma = Mi(i);
        end
    end

    if (Ma > 0)
        Mcrack = this.MzcrackPosBending;
    else
        Mcrack = this.MzcrackNegBending;
    end

    inertiaZ = (Mcrack / Ma)^3 * this.Iz + (1 - (Mcrack / Ma)^3) * this.Izcrack;
    
    % Effective moment of ineartia of the element at a gauss point.
    % But not greater than gross section moment of inertia.
    if (inertiaZ < this.Izcrack), inertiaZ = this.Izcrack; end
    inertiaZ = min(inertiaZ, this.Iz);
    for i = 1:5, this.Izeff(i) = inertiaZ; end

end