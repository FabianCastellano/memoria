import numpy as np
import matplotlib.pyplot as plt

from scipy.spatial import distance
from scipy.signal import convolve2d

dcor = lambda x, y: distance.correlation(x, y)

class compare_images:
    def __init__(self
                 , img_1
                 , img_2
                 , img_1_title = 'img_1'
                 , img_2_title = 'img_2'
                 ):
        

        self.img_1 = img_1
        self.img_2 = img_2

        self.img_1_title = img_1_title
        self.img_2_title = img_2_title

    def show_images(self):
        # plot both images side by side
        fig = plt.figure(figsize=(10, 10))
        ax1 = fig.add_subplot(121)
        ax1.imshow(self.img_1, cmap='gray')
        ax1.set_title(self.img_1_title)

        ax2 = fig.add_subplot(122)
        ax2.imshow(self.img_2, cmap='gray')
        ax2.set_title(self.img_2_title)

        plt.show()
    
    def show_images_scatter(self):
        # plot both images side by side and scatter plot of pixels
        fig, ax = plt.subplots(1, 3, figsize=(15, 5))

        ax[0].imshow(self.img_1, cmap='gray')
        ax[0].set_title(self.img_1_title)

        ax[1].imshow(self.img_2, cmap='gray')
        ax[1].set_title(self.img_2_title)

        ax[2].scatter(self.img_1.flatten(), self.img_2.flatten())
        ax[2].set_xlabel(self.img_1_title)
        ax[2].set_ylabel(self.img_2_title)



        plt.show()
        
    def compare_images(self
                       , function = dcor
                       , comparison_method= 'full'):
        # compare images using a function
        # Add your code here
        if comparison_method == 'full':
            return function(self.img_1.flatten(), self.img_2.flatten())
        elif comparison_method == 'random_full':
            # randomizr order of flattened images in the same way
            img_1_flat = self.img_1.flatten()
            img_2_flat = self.img_2.flatten()

            img_vec = np.array([img_1_flat, img_2_flat]).T

            np.random.shuffle(img_vec)

            img_1_flat = img_vec[:,0]
            img_2_flat = img_vec[:,1]

            return function(img_1_flat, img_2_flat)
        
        elif comparison_method == 'hist':
            img_1_hist = np.histogram(self.img_1.flatten(), bins=256)
            img_2_hist = np.histogram(self.img_2.flatten(), bins=256)
            
            return function(img_1_hist[0], img_2_hist[0])
        
        elif comparison_method == 'conv_mean':
            
            win_size = 3

            conv_filter = np.ones((win_size,win_size))/(win_size**2)

            img_1_conv = self.convolve2D(self.img_1, conv_filter, strides=win_size)
            img_2_conv = self.convolve2D(self.img_2, conv_filter, strides=win_size)

            return function(img_1_conv.flatten(), img_2_conv.flatten())

        elif comparison_method == 'grid_mean':

            img_1 = self.img_1
            img_2 = self.img_2

            resolution = 10

            img_1_grid = img_1.reshape(resolution, -1).mean(axis=(1))
            img_2_grid = img_2.reshape(resolution, -1).mean(axis=(1))

            return function(img_1_grid.flatten(), img_2_grid.flatten()) 

        else:
            raise ValueError('comparison_method not recognized')     




    @staticmethod
    def convolve2D(image, kernel, strides=1):
        
        return convolve2d(image, kernel[::-1, ::-1], mode='valid')[::strides, ::strides]