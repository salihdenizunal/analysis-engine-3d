function epsilon = strainTrussCorotational(c_local, p_local, length)

epsilon = (c_local'* p_local)/length;

end