library(ggplot2)
library(igraph)
library(writexl)
library(readxl)


config_df = as.data.frame(read_excel("SMA_Project/Configurations.xlsx"))
col_names <- c( "SNO","FileNO","n","pt", "n0", "mu","multilevel_community_modularity","walktrap_community_modularity",  "infomap_community_modularity", "louvain_community_modularity", "label_pop_community_modularity", "fast_community_modularity", 
                "multilevel_community_size","walktrap_community_size",  "infomap_community_size", "louvain_community_size", "label_pop_community_size", "fast_community_size",
                "clustering_coefficient", "average_path_length","number_of_nodes")


get_modularity_LFR<-function(){
  for(folder_name in c("LFR")){
    full_path = paste("/home/adnan/Documents/",folder_name,'/',sep="")
    
    
    df = data.frame(matrix(nrow = 0, ncol = length(col_names))) 
    colnames(df) = col_names
    
    for(file_number in 1:375){
      print(paste("File number", file_number))
      
      graph <- read.graph(paste(full_path,file_number,'.gml', sep=""), format=c('gml'))
      wc <- multilevel.community(graph)
      walktrap_community <- cluster_walktrap(graph)
      infomap_community <- cluster_infomap(graph)
      louvain_community  <- cluster_louvain(graph)
      label_pop_community <-cluster_label_prop(graph)
      fast_greedy_community<-cluster_fast_greedy(graph)
      df[nrow(df) + 1,] <- c(file_number, paste(file_number,'.gml',sep=""), 0,0,0,0,modularity(wc), 
                             modularity(walktrap_community), modularity(infomap_community), modularity(louvain_community), modularity(label_pop_community),
                             modularity(fast_greedy_community),length(wc), length(walktrap_community), length(infomap_community), length(louvain_community), length(label_pop_community),
                             length(fast_greedy_community), 
                             transitivity(graph),average.path.length(graph),vcount(graph))
      
      
    }
    df['n']= config_df['n']
    df['pt']= config_df['pt']
    df['n0']=config_df['n0']
    df['mu']=config_df['mu']
    write_xlsx(df, paste("/home/adnan/Documents/",folder_name,'.xlsx', sep=''))
    
    
  }
  return (df)
} 

df_LFR = get_modularity_LFR()

