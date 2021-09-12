function [M1, M2] = calculateBendingMomentsOnBeam(this, alpha, nodalDisplacement)
length = this.length;
elasticityModulus = this.elasticityModulus;
I = this.Iz;

startNodeDisp = nodalDisplacement(this.startNode.id,:);
endNodeDisp = nodalDisplacement(this.endNode.id,:);

theta1 = startNodeDisp(6);
theta2 = endNodeDisp(6);

thatal1 = (theta1-alpha);
thatal2 = (theta2-alpha);

M = [2, 1; 1, 2]*[thatal1; thatal2]*2*elasticityModulus*I/length;

M1 = M(1);
M2 = M(2);

end