# Running pyrho 

make table script executed as: 

```console
sizes=(4 8 20 40 100) 

for i in ${sizes[@]}; do 
sbatch 1.make_table.slurm ${i} 
sbatch 1.make_table.slurm ${i} 100000
done
```

hyperparam table executed as: 

```console
sizes=(4 8 20 40 100)

for i in ${sizes[@]}; do
sbatch 2.hyperparam.slurm ${i} 10000
sbatch 2.hyperparam.slurm ${i} 100000
done
```

optimize requires the vcfs in ../1.simulations/vcfs/sim_{size}_{Ne}.vcf.gz 
and a tab-delimited hyperparam file with  size ne w bp in this dir 
then 
```console
sizes=(4 8 20 40 100)

for i in ${sizes[@]}; do
sbatch 3.optimize.slurm ${i} 10000
sbatch 3.optimize.slurm ${i} 100000 
done
```
