function u = solveForDisplacement(F, Kg)
    u = inv(Kg)*F;
end