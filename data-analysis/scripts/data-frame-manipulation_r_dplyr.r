library(magrittr)
library(dplyr)

df <- read.csv("../_data/titanic.csv")
head(df, 3)

# Rows
nrow(df)

# Columns
length(df)

# Inspect types
str(df)

# Descriptive statistics
summary(df)

# Select rows by number
df[2:4,]

# Select rows by condition
df[df[, "survived"] == 1,] %>% head(3)

# Select rows by multiple conditions
df[df[, "survived"] == 1 & df[, "sex"] == "female",] %>% head(3)

# Select columns by name
df[, c("survived", "pclass")] %>% head(3)

# Assign a (new) column
df$sparkles <- 8
head(df, 3)

# Assign value to some rows
df[df[, "survived"] == 1, "sparkles"] <- 3
head(df, 3)



# Gather / melt

# Spread / cast / pivot



df2 <- data.frame(
    x = c(1,2,3)
    , y = c('a', 'b', 'c')
    , z = c(TRUE, FALSE, TRUE)
)
df2
