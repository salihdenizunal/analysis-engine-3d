function updateIeff(this, Mi)

    for i=1:5
        % If Mi(i) == 0, the inertia will be calculated as NaN. Since it is not
        % smaller than the gross section moment of inertia, that case will be
        % handled in the following control statement.
        if (Mi(i) > 0)
            Mcrack = this.MzcrackPosBending;
        else
            Mcrack = this.MzcrackNegBending;
        end

        inertia = (Mcrack / Mi(i))^3 * this.Iz + (1 - (Mcrack / Mi(i))^3) * this.Izcrack;

        % Effective moment of ineartia of the element at a gauss point.
        % But not greater than gross section moment of inertia.
        if (inertia <= this.Iz)
            if (inertia < this.Izcrack)
                this.Izeff(i) = this.Izcrack;
            else
                this.Izeff(i) = inertia;
            end
        else
            this.Izeff(i) = this.Iz;
        end
    end

end
