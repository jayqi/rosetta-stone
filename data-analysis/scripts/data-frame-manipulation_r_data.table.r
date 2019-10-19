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
    mean_fare = mean(fare, na.rm = TRUE),
    count = .N
), by = pclass]



# Count Pivot Table
data.table::dcast(dt, sex ~ pclass)

# Aggegate Pivot Table
dt_wide <- data.table::dcast(dt, sex ~ pclass, value.var = "age", fun.aggregate = median, na.rm = TRUE)
dt_wide

data.table::melt(dt_wide, id.vars = "sex", measure.vars = c("1", "2", "3"), variable.name = "pclass", value.name = "med_age")

left_dt = dt[1:100, .(name, sex, age)]
right_dt = dt[1:100, .(name, pclass, fare)]

merge(
    left_dt,
    right_dt,
    by = 'name',   # by.x, by.y
    all = FALSE    # all.x, all.y
) %>% head()


