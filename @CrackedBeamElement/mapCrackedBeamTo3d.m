function mapCrackedBeamTo3d(this)

this.K = zeros(12);

this.K(2, 2) = this.k(1, 1);
this.K(2, 6) = this.k(1, 2);
this.K(2, 8) = this.k(1, 3);
this.K(2, 12) = this.k(1, 4);

this.K(6, 2) = this.k(2, 1);
this.K(6, 6) = this.k(2, 2);
this.K(6, 8) = this.k(2, 3);
this.K(6, 12) = this.k(2, 4);

this.K(8, 2) = this.k(3, 1);
this.K(8, 6) = this.k(3, 2);
this.K(8, 8) = this.k(3, 3);
this.K(8, 12) = this.k(3, 4);

this.K(12, 2) = this.k(4, 1);
this.K(12, 6) = this.k(4, 2);
this.K(12, 8) = this.k(4, 3);
this.K(12, 12) = this.k(4, 4);

end
