function tangantStiffness = tangantStiffnessTrussCorotational(UT, elements, nodes, elementTypes, numDof)

nodalDisplacement = getNodalDisplacements(nodes, UT);
numElement = size(elements, 2);
for i = 1:numElement
    
    element = elements(i);
    element = element{1};
    
    length = element.length;
    area = element.area;
    elasticityModulus = element.elasticityModulus;
    
    if elementTypes(element.id) ~= 1
        throw(MException('MyComponent:noSuchVariable','There should be only truss elements!'));
    end
    
    x = x_Truss(element);
     
    p = p_Truss(element, nodalDisplacement);
    
    xPrime = xPrime_Truss(x, p);
    
    cXPrime = cX(xPrime);
    
    z = z_Truss(xPrime);
    
    Ln = updatedLength_Truss(xPrime);
    
    T = Truss_2D_transformation(cXPrime, Ln);
    
    c_local = T * cXPrime / Ln;
    
    p_local = T * p;
    
    epsilon = (Ln - length)/length;
    
    sigma = elasticityModulus * epsilon;
    
    K_t1 = K_t1Corotational(length, area, elasticityModulus, Ln, cXPrime);
    
    KtSigma = KtSigmaCorotational(area, Ln, sigma, z);
    
    Kt(:, :, i) = KtSigma + K_t1;
    
    Kt_3D(:, :, i) = make3D_NonLinK(Kt);
    
end

tangantStiffness = elementToStructureMatrix(Kt_3D, elements, numDof);

end