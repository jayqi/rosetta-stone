#!/usr/bin/env python
# coding: utf-8

# # Data Frame Creation -- python pandas

# In[1]:


import pandas as pd


# ## From columns

# In[9]:


# From lists/arrays of columns
pd.DataFrame.from_dict({
    'x': [1,2,3],
    'y': ['a', 'b', 'c'],
    'z': [True, False, True]
})


# ## From rows

# In[12]:


# From list/array of rows, 2D array
pd.DataFrame.from_records([
    [1, 'a', True],
    [2, 'b', False],
    [3, 'c', True],
], columns=['x', 'y', 'z'])


# In[13]:


# From list of dict rows with column name keys
# File is jsonl / ndjson

pd.DataFrame.from_records([
    {'x': 1, 'y': 'a', 'z': True},
    {'x': 2, 'y': 'b', 'z': False},
    {'x': 3, 'y': 'c', 'z': True},
])


# In[6]:


# From dict rows with column name keys
pd.DataFrame.from_dict({
    'i': {'x': 1, 'y': 'a', 'z': True},
    'ii': {'x': 2, 'y': 'b', 'z': False},
    'iii': {'x': 3, 'y': 'c', 'z': True},
}, orient='index')


# In[ ]:




