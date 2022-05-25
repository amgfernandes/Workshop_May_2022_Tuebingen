#!/usr/bin/env python
# coding: utf-8

# In[1]:


import glob
import pandas as pd
import glob
import seaborn as sns
import pingouin as pg
import matplotlib.pyplot as plt


# In[2]:


'''Example to load all the individual result files'''

files_1h = glob.glob("results_1h/*Results*.csv")
file_count_1h = len(files_1h)

print(f"In total we have {file_count_1h} files")


# In[3]:


# create empty list
dataframes_list_1h = []
  
# append datasets to the list 
for i in range(file_count_1h):
    temp_df = pd.read_csv(files_1h[i])
    dataframes_list_1h.append(temp_df)
      
# display datsets
for dataset_1h in dataframes_list_1h:
    display(dataset_1h)


# In[4]:


df_1h = pd.concat(dataframes_list_1h, axis=0)
df_1h
df_1h['Group'] = '1h'
df_1h


# In[5]:


'''Example to load all the individual result files'''

files_4h = glob.glob("results_4h/*Results*.csv")
file_count_4h = len(files_4h)

print(f"In total we have {file_count_4h} files")


# In[6]:


# create empty list
dataframes_list_4h = []
  
# append datasets to the list 
for i in range(file_count_4h):
    temp_df = pd.read_csv(files_4h[i])
    dataframes_list_4h.append(temp_df)
      
# display datsets
for dataset_4h in dataframes_list_4h:
    display(dataset_4h)


# In[7]:


df_4h = pd.concat(dataframes_list_4h, axis=0)
df_4h['Group'] = '4h'
df_4h


# In[8]:


print(df_1h.describe())
print(df_4h.describe())


# In[9]:


df_together = pd.concat([df_1h,df_4h])
df_together


# # Visualization with seaborn
# https://seaborn.pydata.org/index.html

# In[10]:


plt.figure(figsize=(8, 8))
sns.boxplot(data = df_together, x='Group', y='Mean', palette="Set3")
sns.stripplot(data = df_together, x='Group', y='Mean', color = "black")
plt.ylabel('Number of objects', fontsize = 20)
plt.xlabel('Experiment', fontsize = 20)
plt.yticks(fontsize = 20)
plt.xticks(fontsize = 20)
sns.despine()
plt.tight_layout()
plt.savefig('Counts.png', dpi = 300)


# In[11]:


'''Other way of representing the data'''

plt.figure(figsize=(10, 10))
sns.violinplot(data = df_together, x='Group', y='Mean', palette="Set3")
sns.stripplot(data = df_together, x='Group', y='Mean', color = "black")
sns.despine()
plt.tight_layout()
plt.savefig('Counts_violinplots.png', dpi = 300)


# # Pingouin is an open-source statistical package written in Python 3 
# 
# https://pingouin-stats.org/#
# 

# In[12]:


pg.ttest(df_1h.Mean, df_4h.Mean)


# # Is my data normally distributed?

# In[13]:


print(pg.normality(df_1h.Mean))
print(pg.normality(df_4h.Mean))


# ## The Kruskal-Wallis H-test 
# 
# The Kruskal-Wallis H-test tests the null hypothesis that the population median of all of the groups are equal. It is a non-parametric version of ANOVA. The test works on 2 or more independent samples, which may have different sizes. Due to the assumption that H has a chi square distribution, the number of samples in each group must not be too small. A typical rule is that each sample must have at least 5 measurements.

# In[14]:


pg.kruskal(df_together, dv= 'Mean', between= 'Group')


# ## The Mann–Whitney U test (also called Wilcoxon rank-sum test) is a non-parametric test of the null hypothesis 

# In[15]:


p1 = pg.mwu(df_1h.Area, df_4h.Area)
p1


# In[16]:


p2 = pg.mwu(df_1h.Max, df_4h.Max)
p2


# In[17]:


p3 = pg.mwu(df_1h.Mean, df_4h.Mean)
p3


# # P-values correction for multiple comparisons.
# 
# 

# In[18]:


'''Benjamini–Hochberg FDR correction of an array of p-values'''

pvals = [p1['p-val'].values[0], p2['p-val'].values[0], p3['p-val'].values[0]]
reject, pvals_corr = pg.multicomp(pvals, method='fdr_bh')
print(reject, pvals_corr)


# # There are many ways to vizualize the data

# In[19]:


df_together.head()


# In[20]:


sns.kdeplot(data = df_1h['Mean'])
sns.kdeplot(data = df_4h['Mean'])


# In[21]:


sns.kdeplot(data = df_1h['Mean'])
sns.rugplot(data = df_1h['Mean'], height= 0.1)


# In[22]:


sns.barplot(data = df_together, x='Group', y='Mean', palette="Set3", ci="sd", capsize=.2)


# In[23]:


sns.histplot(df_together.Area)


# In[24]:


df_together.plot(kind='hexbin', x='X', y='Area')


# # Or use Lux to check your datasets
# 
# https://github.com/lux-org/lux

# In[25]:


import lux
from lux.vis.VisList import VisList


# In[26]:


df_lux = df_together.copy()
df_lux


# In[27]:


VisList(["Group=?","Mean"],df_lux)


# In[28]:


df_lux.intent = ["Mean"]


# In[29]:


df_lux

