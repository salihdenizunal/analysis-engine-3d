function K_t2a = Kt2a(length, area, elasticityModulus, b1, b2p)

K_t2a = elasticityModulus * area * length * (b1 * b2p');

end