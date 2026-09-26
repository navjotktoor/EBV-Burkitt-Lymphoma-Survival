# Replication: EBV Variation & Host Driver Mutations in Burkitt Lymphoma

This repository contains dry-lab bioinformatic pipelines and statistical workflows to replicate the findings from **Kim et al., 2025** (*Incorporation of Epstein–Barr viral variation implicates significance of Latent Membrane Protein 1 in survival prediction and prognostic subgrouping in Burkitt lymphoma*).

## Data Sources

1. **EGA Cohort (Kenya, 25 samples):** Accession `EGAD00001005781`
2. **GDC/dbGaP BLGSP Cohort (US, Canada, France, Brazil, Uganda, 105 samples):** Project ID `CGCI-BLGSP` (`phs000235`)
3. **Reference Genomes:**
   - EBV Type 1: `NC_007605`
   - EBV Type 2: `NC_009334`
   - Human: `GRCh38`

## Dependencies

- **Bioinformatics Tools:** `GATK` v4.2.2.0, `SAMtools` v1.16.1, `BEDtools`, `SnpEff`, `SnpSift`, `MAFFT`
- **R Packages:** `glmnet`, `BVSNLP`, `survival`, `NMF`, `ggplot2`

## Execution Steps

1. Preprocess raw WGS BAM files and map against reference EBV genomes (`workflows/`).
2. Run joint variant calling for viral SNPs/Indels using GATK HaplotypeCaller.
3. Perform feature selection via LASSO and Bayesian variable selection Cox models (`analysis/`).
4. Generate NMF prognostic subgroups and plot Kaplan-Meier overall survival curves.
