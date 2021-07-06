function updateIeff(this, Mi)

for i=1:5
    inertia = (this.Mcrack / abs(Mi(i)))^3 * this.I + (1 - (this.Mcrack / abs(Mi(i)))^3) * this.Icrack;

    % Effective moment of ineartia of the element at a gauss point.
    % But not greater than gross section moment of inertia.
    if (inertia <= this.Ieff(i) && inertia >= 0)
        this.Ieff(i) = inertia;
    end
end

end