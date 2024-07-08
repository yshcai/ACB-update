# loading packages
library(ggplot2)
library(cowplot)

# read the file
read <- read.table('./Of_FB283.ccs.fastq.Length_GC.txt',
                   col.names = c('id','length','GC'), header = F, row.names = 1)

# hifi reads length-reads count
p1 <- ggplot(read, aes(x = length))+
  geom_histogram(binwidth = 500, fill = "#b5c6b9", colour = "#b5c6b9")+
  scale_y_continuous(labels = c(0,2,4,6,8)) +
  labs(x = "HiFi reads length (bp)", y = "Reads (1e+05)") +
  theme_bw() +
  theme(axis.text = element_text(size = 11),
        axis.title.x = element_text(size = 13),
        axis.title.y = element_text(size = 13))

# hifi reads length-GC content
p2 <- ggplot(read, aes(x = length, y = GC)) +
  geom_bin2d(bins = 100) + scale_fill_gradient(low = "#f6f5ec", high = "#778286") +
  labs(x = "HiFi reads length (bp)", y = "GC (%)") +
  theme_bw() +
  theme(axis.text = element_text(size = 11),
        axis.title.x = element_text(size = 13),
        axis.title.y = element_text(size = 13))

# GC content-reads count
p3 <- ggplot(read, aes(y = GC))+
  geom_histogram(bins = 100, fill = "#9da396", colour = "#9da396") +
  scale_x_continuous(labels = c(0,2,4,6,8,10)) +
  labs(x = "Reads (1e+05)",y="GC (%)") +
  theme_bw() +
  theme(axis.text = element_text(size = 11),
        axis.title.x = element_text(size = 13),
        axis.title.y = element_text(size = 13))

p4 <- plot_grid(p2, p3, nrow = 1, align = 'h', rel_widths = c(3,1))

plot_grid(p1, p4, ncol = 1, rel_heights = c(1,3), rel_widths = c(1,2))
