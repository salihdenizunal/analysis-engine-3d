function Kg = constructGlobalStiffness(elements,numEqn,tangent)

	Kg = zeros(numEqn, numEqn);
	numElement = size(elements, 2);

	dofNumbering = [1, 2, 3, 4, 5, 6;
		7, 8, 9, 10, 11, 12;
		13, 14, 15, 16, 17, 18;
		19, 20, 21, 22, 23, 24];

	for elemId = 1:numElement
		element = elements{elemId};
		numDofAtNode = size(element.eqnNumbering, 2);
		numNodesOfElement = size(element.eqnNumbering, 1);
		
	    if (tangent)
	        elementContribution = element.Kt;
	    else
	        elementContribution = element.K;
	    end

		for i = 1:numDofAtNode
			for j = 1:numDofAtNode
				for k = 1:numNodesOfElement
					for l = 1:numNodesOfElement
						if ((element.eqnNumbering(k, i) ~= 0) &&  (element.eqnNumbering(l, j) ~= 0))
							Kg(element.eqnNumbering(k, i), element.eqnNumbering(l, j)) = Kg(element.eqnNumbering(k, i), element.eqnNumbering(l, j))+ elementContribution(dofNumbering(k, i), dofNumbering(l, j));
						end
					end
				end
			end
			
		end
	end

end
