# Replicating the EBV-Burkitt Lymphoma Pipeline: A Computational Approach

## Project Overview

This project is an independent computational replication of the bioinformatic and statistical workflows presented in *Kim et al., 2025*. The study investigates how Epstein-Barr virus (EBV) genetic variation—specifically within the Latent Membrane Protein 1 (LMP1) gene—interacts with human tumor driver genes to predict patient survival in Burkitt lymphoma (BL).

Because the 130 whole-genome tumor sequences utilized in the study are restricted access (dbGaP Accession: phs000235 and EGA Accession: EGAD00001005781), this replication focuses on auditing the authors' open-source codebase, reconstructing the computational architecture, and executing a simulated Proof of Concept (POC) of the downstream statistical models.

## Phase 1: Upstream Bioinformatics & Variant Calling

The first half of the pipeline is dedicated to extracting clean viral and human mutation data from raw Whole-Genome Sequencing (WGS) BAM files.

**1. Sequence Preprocessing:**
The pipeline utilizes `GATK 4.2.2.0` and `SAMtools 1.16.1` to align the raw sequence reads against three specific reference genomes pulled from the NCBI Nucleotide database:

* Human reference genome (GRCh38)


* EBV Type 1 (NC_007605)


* EBV Type 2 (NC_009334)



**2. Joint Variant Calling & Annotation:**
Once aligned, the EBV sequences undergo joint variant calling using GATK4 HaplotypeCaller to identify single nucleotide polymorphisms (SNPs) and insertions/deletions (indels). The variants are then annotated using `SnpEff` and filtered with `SnpSift` to isolate the non-synonymous mutations that alter protein function. Missing variants across samples are imputed using the mode.

## Phase 2: Feature Selection (Handling High-Dimensional Data)

The core challenge of the study's dataset is its high dimensionality: there are significantly more identified features (EBV variants and tumor driver genes) than there are patients (n=130).

To solve this, the pipeline employs two variable selection models within a Cox proportional hazards framework:

1. **LASSO Regression (`glmnet` package in R):** Shrinks the coefficients of less important variables to exactly zero, effectively filtering out the statistical noise.


2. **Bayesian Variable Selection (`BVSNLP` package in R):** Evaluates the posterior inclusion probabilities of the remaining features.



Features that survive both models—such as the LMP1 variants G212A and G331Q, along with driver genes like TP53 and ID3—are passed into the final prediction model.

## Phase 3: Prognostic Subgrouping & Survival Analysis

To move from individual mutations to clinical utility, the pipeline uses Non-negative Matrix Factorization (`NMF` package in R) to cluster the patients based on the top selected features.

The model identified three distinct prognostic subgroups defined by different "meta-features":

* **Subgroup 1:** Defined by human driver genes (TP53, MAP3K9) and LMP1 variants (G331Q, H101Q). This group exhibited the highest overall survival.


* **Subgroup 2:** Defined by the ID3 driver gene and the LMP1 I152L variant.


* **Subgroup 3:** Defined by ETS1 and the LMP1 G212A variant, observing the lowest overall survival.



## Simulated Proof of Concept Execution

To validate the downstream statistical methodology without accessing the 5.5 TB of restricted BAM files, I engineered a mock clinical and mutational dataset in R mimicking the study’s parameters (130 patients, country income level, LMP1 variants, and driver genes).

I successfully executed the `glmnet` LASSO Cox regression and `survival` / `survfit` packages to generate the Kaplan-Meier overall survival curves representing the three prognostic subgroups. This execution validates the computational viability of the authors' statistical architecture.
