#%%
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
#%%
df = pd.read_csv('mic.txt', sep='\t')
df.head()

# %%

datos = pd.read_csv('datasaurus.txt', sep='\t', index_col=0).T
datos.head()

# %%

variables = df[['Var1' , 'Var2']].head(10).values

c = 0
br = ''
with open('to_latex.txt', 'w') as f:
    for i,j in variables:
            v1 = datos[i]
            v2 = datos[j]
            plt.scatter(v1, v2)
            plt.title(f'Variables {i} y {j}, MIC = {df.iloc[c].MICe:.3f}')
            title = f'plots/{i}_{j}_.png'
            wtitle = '{'+f'plots/{i}_{j}_.png'+'}'
            plt.savefig(title)
            f.write('\ '[0])
            f.write('begin{figure}[H]\n')
            f.write('\centering\n')
            f.write(f'\includegraphics[scale=0.3]{wtitle}\n')
            caption = '{'+f' MIC = {df.iloc[c].MICe:.3f}'+'}'
            f.write(f'\caption{caption}\n')
            f.write('\end{figure}\n\n')
            plt.show()
            c+=1


# %%




