library(data.table)

# Columns from vectors
data.table::data.table(
    x = c(1,2,3),
    y = c('a', 'b', 'c'),
    z = c(TRUE, FALSE, TRUE)
)

# From list of keyed rows
# ndjson / jsonl format

data.table::rbindlist(list(
    list(x = 1, y = 'a', z = TRUE),
    list(x = 2, y = 'b', z = FALSE),
    list(x = 3, y = 'c', z = TRUE)
))

mat = matrix(1:9, nrow=3)
print(mat)
data.table::data.table(mat)


