function updateIeff(this, Mi)

    for i=1:5
        % If Mi(i) == 0, the inertia will be calculated as NaN. Since it is not
        % smaller than the gross section moment of inertia, that case will be
        % handled in the following control statement.
        if (Mi(i) > 0)
            Mcrack = this.McrackPosBending;
        else
            Mcrack = this.McrackNegBending;
        end

        inertia = (Mcrack / Mi(i))^3 * this.I + (1 - (Mcrack / Mi(i))^3) * this.Icrack;

        % Effective moment of ineartia of the element at a gauss point.
        % But not greater than gross section moment of inertia.
        if (inertia <= this.I)
            if (inertia < this.Icrack)
                this.Ieff(i) = this.Icrack;
            else
                this.Ieff(i) = inertia;
            end
        else
            this.Ieff(i) = this.I;
        end
    end

end
