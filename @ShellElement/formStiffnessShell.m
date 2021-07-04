function K = formStiffnessShell(this)

Loc = [0 -1/sqrt(3) -sqrt(0.6); 0 1/sqrt(3) 0; 0 0 -sqrt(0.6)];
Wgt = [2 1 5/9; 0 1 8/9; 0 0 5/9];

[XY, T] = this.planar();

this.kMembrane = this.formStiffnessMembrane(XY, Loc, Wgt);
this.kPlate = this.formStiffnessPlate(XY, Loc, Wgt);

iMemb = [1 2 6 7 8 12 13 14 18 19 20 24];
iPlt = [3 4 5 9 10 11 15 16 17 21 22 23];

for row = 1:12
    for col = 1:12
        rowSh = iMemb(row);
        colSh = iMemb(col);
        ks(rowSh, colSh) = this.kMembrane(row,col);
    end
end

for row = 1:12
    for col = 1:12
        rowSh = iPlt(row);
        colSh = iPlt(col);
        ks(rowSh, colSh) = this.kPlate(row,col);
    end
end

kPrime = T' * ks * T;

K = this.R' * kPrime * this.R;

end
