function K_t1 = Kt1(length, area, elasticityModulus, b1)

K_t1 = elasticityModulus * area * length * (b1 * b1');

end