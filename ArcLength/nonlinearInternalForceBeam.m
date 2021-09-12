function fi = nonlinearInternalForceBeam(UT, elements, numDof, nodes)

    nodalDisplacement = getNodalDisplacements(nodes, UT);

    fi = zeros(numDof,1);
    numElement = size(elements, 2);

    
    for elemId = 1:numElement
        element = elements{elemId};

        elementFi = element.nonlinearInternalForce(nodalDisplacement);
        if (element.eqnNumbering(1,1) ~= 0) 
        fi( element.eqnNumbering(1,1) ) = fi( element.eqnNumbering(1,1) ) + elementFi(1);
        end
        if (element.eqnNumbering(1,2) ~= 0) 
        fi( element.eqnNumbering(1,6) ) = fi( element.eqnNumbering(1,2) ) + elementFi(2);
        end
         if (element.eqnNumbering(1,6) ~= 0) 
        fi( element.eqnNumbering(1,6) ) = fi( element.eqnNumbering(1,6) ) + elementFi(3);
        end
        if (element.eqnNumbering(2,1) ~= 0) 
        fi( element.eqnNumbering(2,1) ) = fi( element.eqnNumbering(2,1) ) + elementFi(4);
        end
        if (element.eqnNumbering(2,2) ~= 0) 
        fi( element.eqnNumbering(2,2) ) = fi( element.eqnNumbering(2,2) ) + elementFi(5);
        end
        if (element.eqnNumbering(2,6) ~= 0) 
        fi( element.eqnNumbering(2,6) ) = fi( element.eqnNumbering(2,6) ) + elementFi(6);
        end


    end
    
end