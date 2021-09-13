function [M1, M2] = calculateBendingMomentsOnBeam(this, beta0, nodalDisplacement,s ,c)
length = this.length;
elasticityModulus = this.elasticityModulus;
I = this.Iz;

startNodeDisp = nodalDisplacement(this.startNode.id,:);
endNodeDisp = nodalDisplacement(this.endNode.id,:);

theta1 = startNodeDisp(6);
theta2 = endNodeDisp(6);

beta1 = theta1 + beta0;
beta2 = theta2 + beta0;

thatall = atan2((c*sin(beta1)-s*cos(beta1)),(c*cos(beta1)+s*sin(beta1)));
thata2l = atan2((c*sin(beta2)-s*cos(beta2)),(c*cos(beta2)+s*sin(beta2)));

M = [2, 1; 1, 2]*[thatall; thata2l]*2*elasticityModulus*I/length;

M1 = M(1);
M2 = M(2);

end