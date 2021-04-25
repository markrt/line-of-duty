## the data is from this tweet 
# https://twitter.com/anxiousxpress/status/1384147930488082435/photo/1

# load packages
library(tidyverse)
# library(visNetwork) this was more ambition than anything
library(igraph)
library(ggraph)
library(khroma)

# load data
nodes <- 
  read_csv("nodes.csv")
edges <- 
  read_csv("edges.csv")

# reorganise edges data
edges <- 
  edges %>% 
  pivot_longer(Listed:Other,
               names_to = "Relationship",
               values_to = "Edge") %>% 
  select(- Other_what) %>% 
  na.omit =

# generate graph object
line_of_duty <- 
  graph_from_data_frame(edges, vertices = nodes)

# simple plot
ggraph(line_of_duty) +
  geom_edge_link(aes(colour = Relationship,
                     start_cap = circle(2, 'mm'),
                     end_cap = circle(2, 'mm')),
                arrow = arrow(length = unit(4, 'mm'))) +
  geom_node_point(size = 2) +
  theme_graph() +
  geom_node_label(aes(label = name,
                      fill = Alive,
                      colour = as.factor(OCG),
                      angle = as_factor(SandsView)),
                 repel = TRUE) +
  scale_fill_manual(values = c("burlywood", "lightblue"),
                      guide = "none") +
  scale_colour_manual(values = c("black",
                                 "firebrick"),
                      guide = "none") +
  scale_edge_colour_manual(values = c('#CC6677',
                                      '#332288',
                                      '#DDCC77',
                                      '#117733',
                                      '#88CCEE',
                                      '#882255',
                                      '#44AA99',
                                      '#999933',
                                      '#AA4499',
                                      'grey'))

