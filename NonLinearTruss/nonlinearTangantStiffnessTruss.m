function Kt = nonlinearTangantStiffnessTruss(UT, elements, nodes, elementTypes, numDof, strainType)

switch strainType
    case 1
    Kt = tangantStiffnessTruss(UT, elements, nodes, elementTypes, numDof);
    case 2
    Kt = tangantStiffnessTrussCorotational(UT, elements, nodes, elementTypes, numDof);
end

end