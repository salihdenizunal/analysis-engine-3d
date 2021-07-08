function K_t2aT = Kt2aT(length, area, elasticityModulus, b1, b2p)

K_t2aT = elasticityModulus * area * length * (b2p * b1');

end