import correlation_integral as ci
import numpy as np
import matplotlib.pyplot as plt
from auto_smooth import auto_savgol
import pandas as pd


class LocalMaximalCorr:
    def __init__(self, X, Y, grid_size = None , dims = 1, ci_method = "euclidean"):


        self.data = np.vstack((X,Y)).T

        if grid_size is None:
            # print(f"grid_size is {len(self.data)}")
            self.grid_size = len(self.data)

        else:
            self.grid_size = grid_size

        
        
        self.dims = dims
        self.method = ci_method

        self.distances = np.linspace(1/self.grid_size, 1, self.grid_size)

        self.corr = self.get_correlation_integral(self.data, self.method)
        # print('corr',self.corr.shape)


        
    def get_correlation_integral(self, series  ,method = "euclidean"):
        if method == "euclidean":
            corr_int = ci.euclidean(series, self.dims , self.distances )
        elif method == "chebyshev":
            corr_int = ci.chebyshev(series, self.dims , self.distances )
        elif method == "manhattan":
            corr_int = ci.manhattan(series, self.dims , self.distances )
        else:
            raise ValueError("ci_method must be euclidean, chebyshev or manhattan")
        
        # print('corr_int',corr_int.shape)
        return corr_int
        
    def neighbors_density(self, corr_int, smooth = False): 
        density = np.zeros(self.grid_size-1)
        for i in range(self.grid_size-1):
            density[i] += (corr_int[i+1]-corr_int[i])/(1/self.grid_size)
        if smooth:
            # print(pd.Series(density).shape)
            density = auto_savgol(pd.Series(density), plot = False, verbose = False)
            density = density.values
        return density
    
    
    def local_corr(self):
        self.density = self.neighbors_density(self.corr, smooth = True)
        self.null_density = self.get_null_density(self.grid_size)
        local_corr = np.zeros(self.grid_size)
        # print('density',self.density.shape)
        # print('null_density',self.null_density.shape)

        local_corr = self.density - self.null_density
        return local_corr
    
    def local_maximal_corr(self):
        self.local_correlation = self.local_corr()
        return np.max(self.local_correlation), self.distances[np.argmax(self.local_correlation)]
    
    def get_null_density(self, n):
        # get binormal distribution 0, 0 with 1,0,0,1
        null_series = np.random.multivariate_normal([0,0],[[1,0],[0,1]],1000)
        null_corr = self.get_correlation_integral(null_series, self.method)
        null_density = self.neighbors_density(null_corr, smooth=True)
            
        return null_density









