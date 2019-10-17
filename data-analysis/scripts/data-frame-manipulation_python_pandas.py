#!/usr/bin/env python
# coding: utf-8

# # Data Frame Manipulation -- Python pandas

# In[1]:


import pandas as pd
import numpy as np


# ## Load csv

# In[2]:


df = pd.read_csv("../_data/titanic.csv")
df.head(3)


# ## Summary

# In[3]:


# Number of rows
len(df)


# In[4]:


# Number of columns
len(df.columns)


# In[5]:


# Both dimensions
df.shape


# In[6]:


# Inspect types
df.dtypes


# In[7]:


# Descriptive statistics
df.describe()


# ## Slice data

# Doc: https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html

# ### Rows

# In[8]:


# Select rows by number
df.iloc[1:4,:]

# Note that Python is 0-indexed

# Note that Python treats 1:4 as a half-open interval
# i.e., row 4 is not included


# In[9]:


# Select rows by index label (key)
df.loc[1:3]

# This works even for non-integer labels
# Note that label-slicing is end-inclusive


# In[10]:


# Select row by condition
df.loc[df['survived'] == 1].head(3)

# df[df['Survived'] == 1] also works


# In[11]:


# Select rows by multiple conditions
df.loc[(df['survived'] == 1) & (df['sex'] == 'female'),:].head(3)

# Note parentheses for order of operations


# In[12]:


# Can also specify a "callable" function that takes the dataframe as input
df.loc[lambda dfx: (dfx['survived'] == 1) & (dfx['sex'] == 'female'), :].head(3)


# In[13]:


# Select columns by name
df.loc[:, ["survived", "pclass"]].head(3)


# In[14]:


# Select column range by name
df.loc[:, "survived":"name"].head(3)


# ## Assign values

# In[15]:


# Assign a (new) column
df.loc[:, "sparkles"] = 8
df.head(3)


# In[16]:


# Assign value to some rows
df.loc[df["survived"] == 1, "sparkles"] = 3
df.head(3)


# ## Group by

# Named aggregation docs: https://pandas.pydata.org/pandas-docs/stable/user_guide/groupby.html#named-aggregation

# In[17]:


# This named aggregation syntax is new in version 0.25.0.
# 
df.groupby("pclass").agg(
    min_age = ("age", "min"),
    mean_fare = ("fare", np.mean),
    count = ("ticket", "size")
)


# pandas defined aggregation functions
# 
# Function | Description
# --- | ---
# mean() | Compute mean of groups
# sum() | Compute sum of group values
# size() | Compute group sizes (include NaNs)
# count() | Compute count of group (don't include NaNs)
# std() | Standard deviation of groups
# var() | Compute variance of groups
# sem() | Standard error of the mean of groups
# describe() | Generates descriptive statistics
# first() | Compute first of group values
# last() | Compute last of group values
# nth() | Take nth value, or a subset if n is a list
# min() | Compute min of group values
# max() | Compute max of group values

# ## Pivot table

# In[18]:


pd.pivot_table(df, values="age", index="pclass", columns="sex", aggfunc="median")


# ## Reshape

# ## Join

# ## Creation

# In[ ]:




