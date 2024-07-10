# install packages
install.packages("ggplot2")
install.packages("tidyverse")
install.packages("deeptime")
install.packages("ggimage")
install.packages("ggforce")
install.packages("svglite")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("ggtree")
BiocManager::install("clusterProfiler")

# loading packages
library(ggtree)
library(treeio)
library(ape)
library(ggplot2)
library(deeptime)
library(ggimage)
library(ggforce)

# read tree file
tree <- read.mcmctree("FigTree.tre")

# geological time information
time_scale <- get_scale_data(name = 'periods')
time_scale[,2:3] <- time_scale[,2:3]/100

# create a object
p1 <- ggtree(tree, size = 0.5) +
  geom_rootedge(rootedge = 0.1, linewidth = 0.5)

# modify the style of the leaf node label
p2 <- p1 + geom_tiplab(offset = .5, colour = "black", 
                       fontface = 'italic')

# add the label of clade
p3 <- p2 + 
  geom_cladelab(node = 60, label = 'Lepidoptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 59, label = 'Diptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 18, label = 'Siphonaptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 56, label = 'Coleoptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 13, label = 'Neuroptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 12, label = 'Hymenoptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 11, label = 'Psocodea',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 50, label = 'Hemiptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 7, label = 'Thysanoptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 47, label = 'Blattodea',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 4, label = 'Phasmatodea',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 45, label = 'Orthoptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 37, label = 'Odonata',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 1, label = 'Ephemeroptera',
                align = TRUE, offset = -2, offset.text = 0.2) +
  geom_cladelab(node = 77, label = 'Anomopoda',
                align = TRUE, offset = -2, offset.text = 0.2)

# modify the shape of specific internal node
p4 <- p3 + geom_point2(
  aes(subset = (node==76)),
  shape = 24,
  size = 1.5, 
  color = '#8A2BE2', 
  fill = '#8A2BE2')

# add geological time scale
p5 <- p4 + geom_rootedge(rootedge = 0.1, linewidth = 0.1) +
  coord_geo(dat = time_scale, xlim = c(-5.388,6), ylim = c(0, Ntip(tree) + 0.5), 
            neg = TRUE, abbrv = TRUE, 
            height = unit(0.5, "cm"), size = 2.5, lwd = 0.1, color = 'transparent') +
  scale_x_continuous(breaks = seq(-5.0, 0, 1.0), labels = abs(seq(-5.0, 0, 1.0))) +
  theme_tree2()

revts(p5)

# save
ggsave("phylogeny_tree.svg",
       width = 11, height = 8.5, units = "in", dpi = 600)

# refine the figure using Adobe Illustrator
