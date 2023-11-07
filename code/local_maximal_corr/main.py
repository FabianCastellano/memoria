import correlation_integral as ci
import numpy as np
import matplotlib.pyplot as plt

class LocalMaximalCorr:
    def __init__(self, data, dims, grid_size, max_dist):
        self.data = data
        self.dims = dims
        self.grid_size = grid_size
        self.max_dist = max_dist
        self.distances = np.arange(0, max_dist, grid_size)
        self.corr = ci.euclidean(data, dims , self.distances )
    def neighbors_density(self): 
        density = np.zeros(self.grid_size)
        for i in self.corr[:-1]:
            density[i] += (self.corr[i+1]-self.corr[i])/self.grid_size
        return density
    def local_corr(self):
        density = self.neighbors_density()
        null_series = np.random.normal(0, 1, len(self.data))
        null_density = LocalMaximalCorr(null_series, self.dims, self.grid_size, self.max_dist).neighbors_density()
        local_corr = np.zeros(self.grid_size)
        for i in self.corr:
            local_corr[i] = density[i] - null_density()
        return local_corr
    def local_maximal_corr(self):
        max_possition = np.argmax(self.local_corr())
        return self.distances[max_possition]














Cds[:,j] = ci.chebyshev(x,dims[j],rs)
