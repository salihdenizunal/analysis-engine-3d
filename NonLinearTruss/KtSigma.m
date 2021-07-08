function K_tSigma = KtSigma(length, sigmaG, area)

A = [1, -1, 0, 0;
    -1, 1, 0, 0;
    0, 0, 1, -1;
    0, 0, -1, 1];

K_tSigma = ((area * sigmaG)/length) * A;

end
