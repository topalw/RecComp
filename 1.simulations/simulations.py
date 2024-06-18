import stdpopsim

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
