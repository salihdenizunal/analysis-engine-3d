function updateIeff(this, Mi)

for i=1:5
    if (Mi(i) > 0)
        Mcrack = this.McrackPosBending;
    else
        Mcrack = this.McrackNegBending;
    end
    
    inertia = (Mcrack / Mi(i))^3 * this.I + (1 - (Mcrack / Mi(i))^3) * this.Icrack;

    % Effective moment of ineartia of the element at a gauss point.
    % But not greater than gross section moment of inertia.
    if (inertia <= this.Ieff(i) && inertia >= 0)
        this.Ieff(i) = inertia;
    end
end

end