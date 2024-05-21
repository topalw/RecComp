# Running pyrho 

make table script executed as: 

```console
sizes=(8 20 40 100) 

for i in ${sizes[@]}; do 
sbatch 1.make_table.slurm ${i} 
sbatch 1.make_table.slurm ${i} 100000
done
```

hyperparam table executed as: 

```console
sizes=(8 20 40 100)

for i in ${sizes[@]}; do
sbatch 2.hyperparam.slurm ${i}
done
```

