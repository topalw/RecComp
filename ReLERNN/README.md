# Running ReLERNN 

Simulate, Train and Predict as: 

```console
sizes=(2 4 8 20 40 100) 

for i in ${sizes[@]}; do 
sbatch RELERNN_pipeline.slurm ${i} 10000
sbatch RELERNN_pipeline.slurm ${i} 100000
done
```
