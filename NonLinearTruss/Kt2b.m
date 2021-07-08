function K_t2b = Kt2b(length, area, elasticityModulus, b2p)

K_t2b = elasticityModulus * area * length * (b2p * b2p');

end