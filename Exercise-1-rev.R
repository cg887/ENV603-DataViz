#### ENV 603 / 5-April-2021 / N.R. Sommer
# Dataset 1: Religion by region

# If you have not yet installed these libraries, use install.package("")

library(tidyverse)
library(socviz)

# Create a new table called rel_by_region

rel_by_region <- gss_sm %>%
  group_by(bigregion, religion) %>%
  summarize(N = n()) %>%
  mutate(freq = N / sum(N),
         pct = round((freq*100), 0))

# See how the pipeline above has taked the gss_sm dataframe and transformed it into a summary table.

View(gss_sum)
View(rel_by_region)

# Now let's make some plots!

p1 <- ggplot(rel_by_region, aes(x = bigregion, y = pct, fill = religion)) + 
  geom_col(position = "dodge2") +
  labs(x = "Region",y = "Percent", fill = "Religion") +
  theme(legend.position = "top")

p1

p2 <- ggplot(rel_by_region, aes(x = religion, y = pct, fill = religion)) +
  geom_col(position = "dodge2") +
  labs(x = NULL, y = "Percent", fill = "Religion") +
  guides(fill = FALSE) + 
  coord_flip() + 
  facet_grid(~ bigregion)

p2

# Make modifications to either plot. Google is your friend here. A few suggestions:
# (1) Add a title
# (2) Remove the gridlines
# (3) Reorder the bars
# (4) Choose a new color scheme

library(RColorBrewer)

p1 <- ggplot(rel_by_region, aes(x = bigregion, y = pct, fill = religion)) + 
  geom_col(position = "dodge2") +
  labs(x = "Region",y = "Percent", fill = "Religion") +
  theme(legend.position = "top") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black")) +
  labs(title="Religion by U.S. Region", subtitle="Percent of practitioners in major U.S. regions") +
  scale_fill_brewer(palette = "Pastel1")

p1

# Once you're happy with your changes, save your plot:
ggsave("plot1.png",
  plot = last_plot(),
  dpi = 300)