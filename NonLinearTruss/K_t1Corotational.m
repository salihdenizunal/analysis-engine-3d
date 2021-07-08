function K_t1 = K_t1Corotational(length, area, elasticityModulus, Ln, cXPrime)

K_t1 = (elasticityModulus*area/((length^2)*Ln))*cXPrime*cXPrime';

end