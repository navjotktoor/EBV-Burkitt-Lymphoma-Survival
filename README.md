# Replication: EBV Variation & Host Driver Mutations in Burkitt Lymphoma

This repository contains an independent computational replication of the statistical workflows from *Kim et al., 2025* (*Incorporation of Epstein–Barr viral variation implicates significance of Latent Membrane Protein 1 in survival prediction and prognostic subgrouping in Burkitt lymphoma*). 

**Note on Project Scope:** Because the raw 5.5 TB Whole-Genome Sequencing (WGS) BAM files are restricted to authorized Principal Investigators via dbGaP and EGA, this repository focuses on a simulated Proof of Concept (POC) of the study's downstream statistical architecture. 

For a comprehensive technical breakdown of the full theoretical upstream pipeline (GATK/SAMtools) alongside this downstream statistical replication, please read the [Replication Approach & Methodology](Replication_Approach.md).

## Data Sources (Reference)
* **EGA Cohort (Kenya, 25 samples):** Accession EGAD00001005781 
* **GDC/dbGaP BLGSP Cohort (US, Canada, France, Brazil, Uganda, 105 samples):** Project ID CGCI-BLGSP (phs000235)
* **Reference Genomes:** EBV Type 1 (NC_007605), EBV Type 2 (NC_009334), Human (GRCh38)

## Dependencies
* **Bioinformatics Tools (Upstream):** GATK v4.2.2.0, SAMtools v1.16.1, BEDtools, SnpEff, SnpSift, MAFFT
* **Statistical Modeling (Downstream):** R, `glmnet`, `BVSNLP`, `survival`, `NMF`

## Executed Workflow (Proof of Concept)
1. **Simulate Clinical Matrix:** Engineered a mock dataset mirroring the study's parameters (130 patients, country income level, LMP1 variants, and driver genes).
2. **High-Dimensional Feature Selection:** Executed LASSO Cox regression (`glmnet`) to isolate variables significantly associated with patient survival time.
3. **Prognostic Subgrouping:** Generated Kaplan-Meier overall survival curves via the `survival` package to replicate the visual output of the paper's three distinct prognostic subgroups (Replicating Figure 2).
