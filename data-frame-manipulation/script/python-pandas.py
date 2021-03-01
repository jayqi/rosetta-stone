#!/usr/bin/env python
# coding: utf-8

# # Data Frame Manipulation -- Python pandas

import numpy as np
import pandas as pd
from pyprojroot import here

print(f"pandas=={pd.__version__}")


# ## Load csv

df = pd.read_csv(here() / ".data" / "titanic.csv")
df.head(3)


# ## Summary

# Number of rows
len(df)


# Number of columns
len(df.columns)


# Both dimensions
df.shape


# Inspect types
df.dtypes


# Descriptive statistics
df.describe()


# ## Slice data

# Doc: https://pandas.pydata.org/pandas-docs/stable/user_guide/indexing.html

# ### Rows

# Select rows by number
df.iloc[1:4,:]

# Note that Python is 0-indexed

# Note that Python treats 1:4 as a half-open interval
# i.e., row 4 is not included


# Select rows by index label (key)
df.loc[1:3]

# This works even for non-integer labels
# Note that label-slicing is end-inclusive


# Select row by condition
df.loc[df['survived'] == 1].head(3)

# df[df['Survived'] == 1] also works


# Select rows by multiple conditions
df.loc[(df['survived'] == 1) & (df['sex'] == 'female'),:].head(3)

# Note parentheses for order of operations


# Can also specify a "callable" function that takes the dataframe as input
df.loc[lambda dfx: (dfx['survived'] == 1) & (dfx['sex'] == 'female'), :].head(3)


# Select columns by name
df.loc[:, ['survived', 'pclass']].head(3)


# Select column range by name
df.loc[:, 'survived':'name'].head(3)


# ## Assign values

# Assign a (new) column
df.loc[:, 'sparkles'] = 8
df.head(3)


# Assign value to some rows
df.loc[df["survived"] == 1, "sparkles"] = 3
df.head(3)


# ## Group by

# Named aggregation docs: https://pandas.pydata.org/pandas-docs/stable/user_guide/groupby.html#named-aggregation

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

# ## Reshape

# https://pandas.pydata.org/pandas-docs/stable/user_guide/reshaping.html

# ### Spread / Cast / Pivot

# Count pivot table
pd.pivot_table(df, index="sex", columns="pclass", aggfunc="size")


# Aggregate function
df_wide = pd.pivot_table(df, values="age", index="sex", columns="pclass", aggfunc="median")
df_wide


# ### Gather / Melt

df_wide.reset_index().melt(id_vars="sex", value_vars=[1, 2, 3], value_name="med_age")


# ## Join

left_df = df[['name', 'sex', 'age']].iloc[0:100]
right_df = df[['name', 'pclass', 'fare']].iloc[0:100]

left_df.merge(
    right_df, 
    on='name',    # left_on, right_on
    how='inner'   # 'left', 'right', 'outer'
).head()


# ## Rolling Join / As-of Join

# https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.merge_asof.html

left_df = pd.DataFrame({'t': [1, 5, 10], 'left_value': ['a', 'b', 'c']})
left_df


right_df = pd.DataFrame({'t': [1, 2, 3, 6, 7], 'right_value': [1, 2, 3, 6, 7]})
right_df


# Join in rows of right_df with latest value of t before
pd.merge_asof(left_df, right_df, on='t', direction='backward')


# Join in rows of right_df with next value of t after
pd.merge_asof(left_df, right_df, on='t', direction='forward')


# Join in rows of right_df with nearest value of t
pd.merge_asof(left_df, right_df, on='t', direction='nearest')


# ## Row-bind

df1 = df.iloc[0:3]
df2 = df.iloc[3:6]
pd.concat([df1, df2])

# note that this matches column names by default
# controlled by `ignore_index` parameter


# ## Column-bind

df_left = df.iloc[0:3, 0:3]
df_right = df.iloc[0:3, 3:6]
pd.concat([df_left, df_right], axis=1, ignore_index=True)

# note that default `ignore_index=False` will join on index




