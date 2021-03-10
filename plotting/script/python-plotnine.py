#!/usr/bin/env python
# coding: utf-8

import pandas as pd
import plotnine as p9
from pyprojroot import here

p9.theme_set(p9.theme_minimal)
print(f"plotnine=={p9.__version__}")


df = pd.read_csv(here() / ".data" / "titanic.csv")
df.head(3)


# ## Univariate, Continuous Distribution

# ### Histogram

(
    p9.ggplot(df[~df["age"].isna()], p9.aes(x="age"))
    + p9.geom_histogram(binwidth=5)
    + p9.ggtitle("Histogram")
)


# ## ECDF

(
    p9.ggplot(df[~df["age"].isna()], p9.aes(x="age"))
    + p9.stat_ecdf()
    + p9.ggtitle("ECDF")
)


# ## Continuous Distribution, grouped by Categorical

# ### Box Plots

(
    p9.ggplot(df[~df["age"].isna()], p9.aes(x="sex", y="age"))
    + p9.geom_boxplot()
    + p9.coord_flip()
    + p9.ggtitle("Box plot")
)


# ### Violin Plots

(
    p9.ggplot(df[~df["age"].isna()], p9.aes(x="sex", y="age"))
    + p9.geom_violin()
    + p9.coord_flip()
    + p9.ggtitle("Violin Plot")
)


# ## Continuous Metric, grouped by Categorical

mean_age_by_pclass = (
    df.groupby("pclass").agg(mean_age=("age", "mean")).reset_index()
)
mean_age_by_pclass


# ### Bar Chart

(
    p9.ggplot(mean_age_by_pclass, p9.aes(x="pclass", y="mean_age"))
    + p9.geom_bar(stat="identity")
    + p9.coord_flip()
)




