library(data.table)
library(magrittr)

dt <- data.table::fread("../_data/titanic.csv")
head(dt, 3)

# Rows
nrow(dt)

# Columns
length(dt)

# Inspect types
str(dt)

# Descriptive statistics
summary(dt)

# Select rows by number
dt[2:4,]

# Select rows by condition
dt[survived == 1,] %>% head(4)

# Select rows by multiple conditions
dt[survived == 1 & sex == "female",] %>% head(3)

# Select columns by name
dt[, .(survived, pclass)] %>% head(3)

# Assign a (new) column
dt[, sparkles := 8]
head(dt, 3)

# Assign value to some rows
dt[survived == 1, sparkles := 3]
head(dt, 3)

dt[, .(
    min_age = min(age, na.rm = TRUE), 
    mean_fare = mean(fare)
), by = pclass]



# Gather / melt

# Spread / cast / pivot



dt2 <- data.table::data.table(
    x = c(1,2,3),
    y = c('a', 'b', 'c'),
    z = c(TRUE, FALSE, TRUE)
)
dt2
