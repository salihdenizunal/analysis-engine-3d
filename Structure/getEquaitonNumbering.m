function [eqnNumbering, numEqn] = getEquaitonNumbering(numNode, supports)

    numSupport = size(supports, 1);
    numDofAtNode = (size(supports, 2)-1);
    eqnNumbering = zeros(numNode, numDofAtNode);
    
    for i = 1:numSupport
           supportId = supports(i, 1);
           eqnNumbering(supportId, :) = supports(i, 2:(numDofAtNode+1));
    end
    
    counter = 1;
    for i = 1:numNode
        for j = 1:numDofAtNode
            if(eqnNumbering(i, j) == 0)
                eqnNumbering(i, j) = counter;
                counter = counter + 1;
            else
                eqnNumbering(i, j) = 0;
            end
        end
    end

    % Return the number of equations.
    numEqn = counter - 1;

end
