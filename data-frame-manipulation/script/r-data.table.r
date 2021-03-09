library(data.table)
library(magrittr)

packageVersion("data.table")

dt <- data.table::fread(here::here(".data", "titanic.csv"))
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

# Setup
left_dt = data.table::data.table(t = c(1, 5, 10), left_value = c('a', 'b', 'c'))
data.table::setkeyv(left_dt, "t")
right_dt = data.table::data.table(t = c(1, 2, 3, 6, 7), right_value = c(1, 2, 3, 6, 7))
data.table::setkeyv(right_dt, "t")

# Join in rows of right_dt with latest value of t before
right_dt[left_dt, roll = Inf]

# Note bracket join syntax being backwards: select left_dt's rows, from right_dt
# This is reverse join in R's convention, but a forward join in Python's.

# Join in rows of right_dt with next value of t after
right_dt[left_dt, roll = -Inf]

# Note bracket join syntax being backwards: select left_dt's rows, from right_dt
# This is a forward join in R's convention, but a reverse join in Python's.

dt1 = dt[1:3]
dt2 = dt[4:6]

data.table::rbindlist(list(dt1, dt2), use.names = TRUE)
# fill = TRUE to include disjoint columns and fill with NA

dt_left = dt[0:3, 1:3]
dt_right = dt[0:3, 4:6]
cbind(dt_left, dt_right)


