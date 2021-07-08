function tangantStiffness = tangantStiffnessTruss(UT, elements, nodes, elementTypes, numDof)

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
    
    b1 = b1_Truss(element, length);
    
    b2p = b2p_Truss(element, nodalDisplacement, length);
     
    p = p_Truss(element, nodalDisplacement);
    
    epsilon = strainTruss(b1, p, length);
    
    sigmaG = element.elasticityModulus * epsilon;
    
    K_tSigma = KtSigma(length, sigmaG, area);
    
    K_t1 = Kt1(length, area, elasticityModulus, b1);
    
    K_t2a = Kt2a(length, area, elasticityModulus, b1, b2p);
    
    K_t2aT = Kt2aT(length, area, elasticityModulus, b1, b2p);
    
    K_t2b = Kt2b(length, area, elasticityModulus, b2p);
    
    Kt(:, :, i) = K_tSigma + K_t1 + K_t2a + K_t2aT + K_t2b;
    
    Kt_3D(:, :, i) = make3D_NonLinK(Kt);
    
end

tangantStiffness = elementToStructureMatrix(Kt_3D, elements, numDof);

end