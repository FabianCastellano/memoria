from scipy import stats
import matplotlib.pyplot as plt
import numpy as np


class BoxCoxImg:
    def __init__(self, img_path):
        self.img = plt.imread(img_path)
        self.bw_img = self.black_white()

    def show(self):
        plt.imshow(self.img)
        plt.show()

    def get_lambda(self, X):
        return stats.boxcox(X)[1]
    
    def normalize(self, X):
        return (X - X.min()) / (X.max() - X.min()) + 0.00001
    
    def normalize_reshape(self, X, shape):
        return self.normalize(X).reshape(shape)
    
    def black_white(self):
         return 0.299*self.img[:,:,0] + 0.587*self.img[:,:,1] + 0.114*self.img[:,:,2]

         
    def transform(self, lam=None, method='full', normalize=True):
        X = self.bw_img.flatten()
        
        if normalize:
            X = self.normalize(X)


        if lam is not None:

            img = stats.boxcox(X, lam)

            return self.normalize_reshape(img, shape = self.bw_img.shape)
        
        else:

            if method == 'full':
                img, lam = stats.boxcox(X)
                return self.normalize_reshape(img, shape = self.bw_img.shape), lam
 
            elif method == 'hist':
        

                X_hist = np.histogram(X, bins=256)

                lam = self.get_lambda(X_hist[0]+1)

                img = stats.boxcox(X, lam)


                return self.normalize_reshape(img, shape = self.bw_img.shape), lam
            elif method == 'grid':
                
                X = self.bw_img.copy()

                resolution = 10

                lam = np.array([])
                # print(X.shape)

                for i in range(0, X.shape[0], resolution):
                    for j in range(0, X.shape[1], resolution):
                        window = X[i:i+resolution, j:j+resolution].flatten()
                        try:
                            bc_window, current_lam = stats.boxcox(window)
                            lam = np.append(lam, current_lam)
                        except:
                            continue
                lam = lam.mean()

                return self.transform(lam=lam), lam
            
            elif method == 'moving_window':

                X = self.bw_img.copy()

                lam = np.zeros(X.shape)

                resolution = 10

                for i in range(0, X.shape[0], 1):
                    for j in range(0, X.shape[1], 1):
                        window = X[i:i+resolution, j:j+resolution].flatten()
                        try:
                            bc_window, current_lam = stats.boxcox(window)
                            lam = np.append(lam, current_lam)
                        except:
                            continue
                lam = lam.mean()
                return self.transform(lam=lam), lam


        
            elif method == 'moving_window_moving_lambda':
                
                X = self.bw_img.copy()

                img = np.zeros(X.shape)
                lam = np.zeros(X.shape)
                # print(X.shape)

                for i in range(0, X.shape[0], 10):
                    for j in range(0, X.shape[1], 10):
                        window = X[i:i+10, j:j+10].flatten()
                        try:
                            bc_window, current_lam = stats.boxcox(window)
                        except:
                            current_lam = 1
                            bc_window = stats.boxcox(window, current_lam)
            
                        if len(bc_window) == 100:
                            img[i:i+10, j:j+10] = bc_window.reshape(10, 10)
                            lam[i:i+10, j:j+10] = current_lam
                        elif len(bc_window) == (X.shape[0] - i)*10:
                            # fix boundary issues
                            img[i:i+10, j:j+10] = bc_window[:100].reshape((X.shape[0] - i), 10)
                            lam[i:i+10, j:j+10] = current_lam
                        elif len(bc_window) == (X.shape[1] - j)*10:
                            # fix boundary issues
                            img[i:i+10, j:j+10] = bc_window[:100].reshape(10, (X.shape[1] - j))
                            lam[i:i+10, j:j+10] = current_lam
                        else:
                            img[i:i+10, j:j+10] = bc_window[:100].reshape((X.shape[0] - i),(X.shape[1] - j))
                            lam[i:i+10, j:j+10] = current_lam

                return self.normalize_reshape(img, shape=self.bw_img.shape), lam