function fi = nonlinearInternalForceTruss(UT, elements, nodes, elementTypes, numDof, strainType)

switch strainType
    case 1
    fi = internalForceTruss(UT, elements, nodes, elementTypes, numDof);
    case 2
    fi = internalForceTrussCorotational(UT, elements, nodes, elementTypes, numDof);
end

end