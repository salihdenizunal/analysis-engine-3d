function J = formJacobian(this, ksi, eta, XY)

D = this.D4(ksi, eta);
J = D * XY;

end
