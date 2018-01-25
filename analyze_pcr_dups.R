
library(tidyverse)

lib5 <- read.delim("~/Desktop/lib5_normal_PCRdup_res/lib5_PCRdup_res.text", header = F) %>%
  select(-V5)
colnames(lib5) <- c("sample", "total.reads", "retained.reads", "percentDups")

cor.test(lib5$total.reads, lib5$percentDups)

summary <- lib5 %>%
  gather(total.reads:percentDups, key = "key", value = "value", factor_key = T) %>%
  group_by(key) %>%
  mutate(mean = mean(value),
         sd = sd (value)) %>%
  mutate(CV = sd/mean) %>%
  ungroup() %>%
  select(-value, -sample) %>%
  distinct()


