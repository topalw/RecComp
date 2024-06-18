{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0e2bd026",
   "metadata": {},
   "outputs": [],
   "source": [
    "import stdpopsim\n",
    "\n",
    "#number of samples\n",
    "sample_size = [2,4,10,20,50]\n",
    "\n",
    "#population size\n",
    "size = [10000,100000]\n",
    "\n",
    "\n",
    "for i in size:\n",
    "    for j in sample_size:\n",
    "        \n",
    "        species = stdpopsim.get_species(\"HomSap\")\n",
    "        model = stdpopsim.PiecewiseConstantSize(N0=i)\n",
    "        contig = species.get_contig(\"chr22\", \"DeCodeSexAveraged_GRCh38\")\n",
    "        samples = {\"pop_0\": j}\n",
    "        engine = stdpopsim.get_engine(\"msprime\")\n",
    "        ts = engine.simulate(model, contig, samples)\n",
    "        with open(f\"sims_{j}_{i}.vcf\", \"w\") as vcf_file:\n",
    "            ts.write_vcf(vcf_file, contig_id=\"22\")"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.11.5"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
