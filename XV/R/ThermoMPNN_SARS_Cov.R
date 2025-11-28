library(ggplot2)
library(tidyverse)
library(ggExtra)


output <- read_csv("XV/out/6m0j/single_thr100_6m0j.csv")

c380 <- read_csv2("XV/data/C380.csv")
c3684 <- read_csv2("XV/data/C3684.csv")

filtered_output <- output |>
  filter(Mutation %in% c380$`Mutation(s)`)


head(c380)
head(filtered_output)

identical(c380$`Mutation(s)`, filtered_output$Mutation)

view(output)





df <-
  tibble(
    PDB = filtered_c380$PDB,
    mut = filtered_c380$`Mutation(s)`,
    ddg_exp = as.numeric(c380$DDGb),
    region = as.factor(c380$region),
    ddg_out = as.numeric(filtered_output$`ddG (kcal/mol)`)
  )

tests = c("pearson", "spearman", "kendall")

for (test in tests){
  testval <- cor.test(df$ddg_exp, df$ddg_out,
           method = test)
  print(testval)
  }

p1 <- ggplot(df, aes (x = ddg_exp, y = ddg_out, color = region)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", color = "red") +
  geom_abline(slope = 1, intercept = 0, color = "green", linetype = "dashed", linewidth = 1) +
  coord_fixed() +
  theme_bw() +
  labs(
    x = "Experimental ddG",
    y = "Modelled ddG",
    title = "Scatterplot of experimental vs Modelled ddG"
  )

ggMarginal(
  p1,
  type = "density",
  margins = "both",
  groupFill = TRUE
)

df_noncore <- df |> filter(region != "Core")

glimpse(df_noncore)
summary(df_noncore)


p2 <- ggplot(df_noncore, aes (x = ddg_exp, y = ddg_out, color = region)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", color = "red") +
  geom_abline(slope = 1, intercept = 0, color = "green", linetype = "dashed", linewidth = 1) +
  theme_bw() +
  coord_fixed() +
  labs(
    x = "Experimental ddG",
    y = "Modelled ddG",
    title = "Scatterplot of experimental vs Modelled ddG"
  )

ggMarginal(
  p2,
  type = "density",
  margins = "both",
  groupFill = TRUE
)


for (test in tests){
  testval <- cor.test(df_noncore$ddg_exp, df_noncore$ddg_out,
                      method = test)
  print(testval)
  }



