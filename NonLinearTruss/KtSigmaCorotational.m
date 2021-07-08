function KtSigma = KtSigmaCorotational(area, Ln, sigma, z)

KtSigma = (area*sigma/Ln^3)*(z*z');

end