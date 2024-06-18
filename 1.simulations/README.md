# Simulations 


We will be simulating vcf files for the human chromosome 22, by using STDPOPSIM's python API.

The sample sizes will be 2,4,10,20 and 50. Since we are working with diploid
samples these numbers are doubled.

The piecewise constant model was selected for population sizes 10.000 and 100.000.

The selected simulation engine used internally by stdpopsim is MSPRIME.

The genetic map that will be used for the simulations is DeCodeSexAveraged_GRCh38
and the mutation rate is 1.29e-08.

First, we import stdpopsim

```python
import stdpopsim
```

Then we run the script bellow in order to obtain all the simulated vcf files

```python
#number of samples
sample_size = [2,4,10,20,50]

#population size
size = [10000,100000]


for i in size:
    for j in sample_size:
        
        species = stdpopsim.get_species("HomSap")
        model = stdpopsim.PiecewiseConstantSize(N0=i)
        contig = species.get_contig("chr22", "DeCodeSexAveraged_GRCh38")
        samples = {"pop_0": j}
        engine = stdpopsim.get_engine("msprime")
        ts = engine.simulate(model, contig, samples)
        with open(f"sims_{j}_{i}.vcf", "w") as vcf_file:
            ts.write_vcf(vcf_file, contig_id="22")
```
