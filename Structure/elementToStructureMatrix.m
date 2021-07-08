function Ks  = elementToStructureMatrix(Ke, elements, numDof)
Ks = zeros(numDof);

numElement = size(elements, 2);

dofNumbering = [1, 2, 3, 4, 5, 6;
    7, 8, 9, 10, 11, 12;
    13, 14, 15, 16, 17, 18;
    19, 20, 21, 22, 23, 24];
for i = 1:numElement
    element = elements(i);
    element = element{1};
    
    numDofAtNode = size(element.eqnNumbering, 2);
    numNodesOfElement = size(element.eqnNumbering, 1);
    
    eqnNumbering = element.eqnNumbering;
    
    for j = 1:numDofAtNode
        for k = 1:numDofAtNode
            for m = 1:numNodesOfElement
                for n = 1:numNodesOfElement
                    if ((eqnNumbering(m, j) ~= 0) &&  (eqnNumbering(n,k) ~= 0))
                        Ks(eqnNumbering(m, j), eqnNumbering(n, k)) = Ks(eqnNumbering(m, j), eqnNumbering(n, k)) + Ke(dofNumbering(m, j), dofNumbering(n, k), i);
                    end
                end
            end
        end
    end
end
end