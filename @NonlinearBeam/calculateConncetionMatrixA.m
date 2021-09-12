function A = calculateConncetionMatrixA(this, z, ln)

At = ([0, 0, 1, 0, 0, 0; 0, 0, 0, 0, 0, 1]-[z';z']/(ln));

A = At';

end