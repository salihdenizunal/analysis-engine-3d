function Kt = nonlinearTangentStiffnessBeam(dispAtIncrement, elements, numDof, nodes)
    nodalDisplacement = getNodalDisplacements(nodes, dispAtIncrement);
    
    numElement = size(elements, 2);
    
    for elemId = 1: numElement
		element = elements{elemId};
		element.updateStiffness(nodalDisplacement);
    end
    
    Kt = constructGlobalStiffness(elements, numDof);
end