function Fi = getInternalForcesCrackedBeam(elements,numEqn, d)

Fi = zeros(numEqn,1);
numElement = size(elements, 2);

for elemId = 1:numElement
	element = elements{elemId};
	
	elementFi = element.calculateInternalForces(d);
	if (element.eqnNumbering(1,2) ~= 0) 
	Fi( element.eqnNumbering(1,2) ) = Fi( element.eqnNumbering(1,2) ) + elementFi(1);
	end
	if (element.eqnNumbering(1,6) ~= 0) 
	Fi( element.eqnNumbering(1,6) ) = Fi( element.eqnNumbering(1,6) ) + elementFi(2);
	end
	if (element.eqnNumbering(2,2) ~= 0) 
	Fi( element.eqnNumbering(2,2) ) = Fi( element.eqnNumbering(2,2) ) + elementFi(3);
	end
	if (element.eqnNumbering(2,6) ~= 0) 
	Fi( element.eqnNumbering(2,6) ) = Fi( element.eqnNumbering(2,6) ) + elementFi(4);
	end
	

end

end