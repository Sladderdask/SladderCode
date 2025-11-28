library(ggplot2)
library(ggExtra)
library(tidyverse)
library(sys)
library(glue)
library(seqinr)
library(stringr)

#> Make a function that takes a given file and extracts the mutation  and
#> corresponding score and turns it into. The mutation column needs to look
#> like the column in the output file so that i can filter the mutations.
#>
#> Calculate correlation scores for all of the binding partners and create
#> scatter plots which that look good.
#>
#> Attempt to color the scatter plot according to residue location?


formatMave <- function(pdb){


  }


#load and frame in the relevant data files
pdb <- toupper("4obe")
path_mave <- Sys.glob(glue("XV/data/*_{pdb}.csv"))
path_out <- Sys.glob(glue("XV/out/mave/thr100_{pdb}.csv"))
mave_df <- read_csv(path_mave)
out_df <- read_csv(path_out)

#verify
view(mave_df)
view(out_df)

#initiate MAVE df with relevant data and choose names for columns
mdf <- tibble(
  mutation_unformatted = mave_df$hgvs_pro,
  ddG_mave = as.numeric(mave_df$score)
  )

summary(mdf)

mdf <- mdf |> filter(!is.na(ddG_mave))

summary(mdf)

#Formatting MAVE mutation column
clean_mdf <- mdf |> mutate(mutation_ = str_remove(mutation_unformatted, "^p\\."),
                   wt3 = str_extract(mutation_, "^[A-Za-z]{3}"),
                   pos = str_extract(mutation_, "\\d+"),
                   mut3 = str_extract(mutation_, "[A-Za-z]{3}$"),
                   wt1 = a(wt3),
                   mut1 = a(mut3),
                   mutation = paste0(wt1, pos, mut1)
                   )
head(clean_mdf)
summary(clean_mdf)

#Formatting out mutation column
summary(out_df)


odf <- tibble(
  ddG_out = as.numeric(out_df$`ddG (kcal/mol)`),
  mutation_unformatted = out_df$Mutation
)


summary(odf)

clean_odf <- odf |> mutate(mutation = str_sub(mutation_unformatted, 1, 1) %>%
                             str_c(str_sub(mutation_unformatted, 3))
                          )
tail(clean_odf)
summary(clean_odf)

flr_clean_odf <- clean_odf |> filter(mutation %in% clean_mdf$mutation)

summary(flr_clean_odf)

identical(flr_clean_odf$mutation, clean_mdf$mutation)
#false

#> they should be the same if i am looking at the same proteins since the output
#> from ThermoMPNN gives all possible mutations from a starting point. Could it be
#> that the starting points were different, ie. that the MAVE data set had some
#> mutations to begin with? i should find the different protein sequences and
#> see if they are identical, if not we will have found the issue.


