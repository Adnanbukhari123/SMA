Community Detection Algorithms: Comparative
testing on Benchmark Graphs
## Data Gathering

* To generte data that is used for analysis please run LFR_Data_Genration_File.r file
| Parameter | Type     | File(which Generate data)                |
| :-------- | :------- | :------------------------- |
| `Configurations.xlsx` | `xlsx` | LFR_Data_Genration_File.R |

The LFR_Data_Genration_File is going to produce LFR.csv which will use for analysis. 
 



## Analysis 

* For the analysis please run lfr_plots.R
| Parameter | Type     | File(which Generate data)                |
| :-------- | :------- | :------------------------- |
| `LFR.csv` | `csv` | lfr_plots.R |

 We compare the six different algorithms:
 * Multilevel
 * Walktrap
 * Infomap
 * Louvain
 * Label Pop
 * Fast Geedy

 We compare the performance of six algorithms on modularity metric; we had ran
 six algorithms on 375 graphs then we group by  modularities on (n,mu)  of different Algorithms, and
 took the average. Futhermore, we plot the average modularities of Algorithms against *μ* to see the differences. Finally, we compare the modularities of Different 
 algorithms against Networksize.  