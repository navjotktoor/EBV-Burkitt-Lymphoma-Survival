ebv-burkitt-survival-replication/
│
├── README.md                  # Project overview & replication instructions
├── data/                      # Local data directory (gitignored)
│   ├── raw/                   # Raw EGA and GDC BAM/FastQ downloads
│   ├── metadata/              # Clinical phenotypes & accession mapping
│   └── processed/             # Genotype matrices, variant call VCFs
│
├── workflows/                 # Preprocessing & alignment scripts
│   ├── 01_download_data.sh    # Data download scripts (GDC API / EGA client)
│   ├── 02_alignment.sh        # BWA/SAMtools alignment against EBV reference
│   └── 03_variant_calling.sh  # GATK HaplotypeCaller pipeline
│
├── analysis/                  # Statistical modeling & machine learning (R)
│   ├── 01_data_preprocessing.R# Filtering, mode imputation, mutation matrix
│   ├── 02_variable_selection.R# LASSO Cox (glmnet) & Bayesian Cox (BVSNLP)
│   └── 03_subgrouping_survival.R # NMF clustering & Kaplan-Meier survival curves
│
└── requirements.txt           # Environment dependencies (Conda / R packages)
