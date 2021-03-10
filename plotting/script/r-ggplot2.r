library(data.table)
library(ggplot2)

options(repr.plot.width = 8, repr.plot.height = 8)

packageVersion("ggplot2")

dt <- data.table::fread(here::here(".data", "titanic.csv"))
head(dt, 3)

ggplot(dt[!is.na(age)], aes(x = age)) +
  geom_histogram(binwidth = 5) +
  ggtitle("Histogram")

ggplot(dt[!is.na(age)], aes(x = age)) +
  stat_ecdf(pad = FALSE) +
  ggtitle("ECDF")

ggplot(dt[!is.na(age)], aes(x = sex, y = age)) +
  geom_boxplot() +
  coord_flip() +
  ggtitle("ECDF")

ggplot(dt[!is.na(age)], aes(x = sex, y = age)) +
  geom_violin() +
  coord_flip() +
  ggtitle("ECDF")

mean_age_by_pclass <- dt[, .(mean_age = mean(age, na.rm = TRUE)), by = "pclass"]

ggplot(mean_age_by_pclass, aes(x = pclass, y = mean_age)) +
  geom_bar(stat = "identity") +
  coord_flip()


