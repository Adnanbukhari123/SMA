library(ggplot2)
library(dplyr)
library(tidyverse)
library(readxl)
library(grid)

df_lfr = read.csv("SMA_Project/LFR.csv")

avg_data <- df_lfr %>% group_by(n, mu) %>% summarise_at(vars(multilevel_community_modularity, walktrap_community_modularity,
                                                                  infomap_community_modularity,louvain_community_modularity, label_pop_community_modularity,
                                                                  fast_community_modularity), mean) %>% data.frame()

avg_data %>% ggplot(mapping=aes(n,multilevel_community_modularity, color=factor(n)))+geom_line()+geom_point()+facet_wrap(~n)

#avg_data %>% ggplot(mapping = aes(mu,multilevel_community_modularity, color=factor(n))) + geom_line()+geom_point()
mc <-avg_data %>% ggplot(mapping=aes(mu,multilevel_community_modularity, color=factor(n), shape=factor(n)))+labs(x='Mixing Parameter( μ )',y='Multilevel Modularity', title = " Graph LFR")+
  geom_line(linetype="solid",size=1)+geom_point(size=2)
wc <-avg_data%>%  ggplot(mapping = aes(mu, walktrap_community_modularity, color=factor(n), shape=factor(n)))+labs(x='Mixing Parameter( μ )', y='Walktrap Modularity', title = " Graph LFR")+
  geom_line(linetype="dotted",size=1)+geom_point(size=2)
ic <- avg_data%>%  ggplot(mapping = aes(mu, infomap_community_modularity, color=factor(n), shape=factor(n)))+labs(x='Mixing Parameter( μ )', y='Infomap Modularity', title = "Graph LFR")+
  geom_line(linetype="dotted",size=1)+geom_point(size=2)
lc <-avg_data%>%  ggplot(mapping = aes(mu, louvain_community_modularity, color=factor(n), shape=factor(n)))+labs(x='Mixing Parameter( μ )', y='Louvain Modularity', title = "Graph LFR")+
  geom_line(linetype="dotted",size=1)+geom_point(size=2)
labc <-avg_data%>%  ggplot(mapping = aes(mu, label_pop_community_modularity, color=factor(n), shape=factor(n)))+labs(x='Mixing Parameter( μ )', y='Labelpop Modularity', title = "Graph LFR")+
  geom_line(linetype="dotted", size=1)+geom_point(size=2)
fc <- avg_data%>%  ggplot(mapping = aes(mu, fast_community_modularity, color=factor(n), shape=factor(n)))+labs(x='Mixing Parameter( μ )', y='Fast Modularity', title = "Graph LFR")+
  geom_line(linetype="dotted", size=1)+geom_point(size=2)

df=as.data.frame(t(df_lfr))

avg_modularity <- df_lfr %>% group_by(n) %>% summarise_at(vars(multilevel_community_modularity, walktrap_community_modularity,
                                                              infomap_community_modularity,louvain_community_modularity, label_pop_community_modularity,
                                                              fast_community_modularity), mean) %>% data.frame()


y_values <- gather(avg_modularity,Algorithm, y, -n)
ggplot(y_values, aes(n, y, color = Algorithm, shape=Algorithm)) + labs(x='Network size',y='Modularities')+geom_line(linetype="dotted", size=1)+geom_point(size=2)



