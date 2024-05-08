rule all:
    input:
        "plots/quals.svg"

rule fastqc:
    input: 
        "data/SRR1017128.fastq"
    output: 
        "fastqc/SRR1017128_fastqc.zip"
    conda:
        "environment.yaml"
    log:
        "logs/SRR1017128_fastqc.log"
    shell:
        "fastqc --log {log} {input} -o fastqc"

# Second rule: Trim the reads
rule trim_reads:
    input: 
        "data/SRR1017128.fastq"  # This should be the original FASTQ
    output: 
        "trimmed/SRR1017128_trimmed.fastq"
    conda:
        "environment.yaml"
    log:
        "logs/SRR1017128_trimmed.log"
    shell:
        """
        trimmomatic SE -phred33 {input} {output} \
            ILLUMINACLIP:TruSeq3-SE.fa:2:30:10 \
            LEADING:10 \
            TRAILING:10 \
            SLIDINGWINDOW:4:20 \
            MINLEN:36
        """
rule fastqc_again:
    input: 
        "trimmed/SRR1017128_trimmed.fastq"
    output: 
        "fastqc/trimmed/SRR1017128_fastqc.zip"
    conda:
        "environment.yaml"
    log:
        "logs/SRR1017128_trimmed_fastqc.log"
    shell:
        "fastqc --log {log} {input} -o fastqc/trimmed"

#FASTQ_PARTS = ["part_aa", "part_ab", "part_ac", "part_ad", "part_ae", "part_af", "part_ag", "part_ah", "part_ai", "part_aj"]
#total_records=$(cat trimmed/SRR1017128_trimmed.fastq | wc -l | awk '{print int($1/4)}')
#records_per_chunk=$(echo "$total_records / 10" | bc)
#split -l $((records_per_chunk * 4)) SRR1017128_trimmed.fastq part_
rule bwa_map:
    input:
        "data/genome.fa",
        "trimmed/part_aa.fastq"
    output:
        "mapped_reads/SRR1017128_trimmed_part_aa.bam"
    threads: 95  # This line specifies the maximum threads this rule can use
    shell:
        "bwa mem {input} | samtools view -Sb - > {output}"

rule samtools_sort:
    input:
        "mapped_reads/SRR1017128_trimmed_part_aa.bam"
    output:
        "sorted_reads/SRR1017128_trimmed_part_aa.bam"
    shell:
        "samtools sort -T sorted_reads/SRR1017128_trimmed_part_aa "
        "-O bam {input} > {output}"

rule samtools_index:
    input:
        "sorted_reads/SRR1017128_trimmed_part_aa.bam"
    output:
        "sorted_reads/SRR1017128_trimmed_part_aa.bam.bai"
    shell:
        "samtools index {input}"

#snakemake --dag sorted_reads/SRR1017128_trimmed_part_aa.bam.bai | dot -Tsvg > dag.svg

rule bcftools_call:
    input:
        fa="data/genome.fa",
        bam="sorted_reads/SRR1017128_trimmed_part_aa.bam",
        bai="sorted_reads/SRR1017128_trimmed_part_aa.bam.bai"
    output:
        "calls/all.vcf"
    shell:
        "bcftools mpileup -f {input.fa} {input.bam} | "
        "bcftools call -mv - > {output}"

#snakemake --dag calls/all.vcf | dot -Tsvg > dag_bcftools_call.svg

rule plot_quals:
    input:
        "calls/all.vcf"
    output:
        "plots/quals.svg"
    script:
        "scripts/plot-quals.py"


#  find . -name '*.fa' -type f
# ./mambaforge/envs/nbd/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa
# ./mambaforge/envs/nbd/share/trimmomatic-0.39-2/adapters/TruSeq2-PE.fa
# ./mambaforge/envs/nbd/share/trimmomatic-0.39-2/adapters/TruSeq2-SE.fa
# ./mambaforge/envs/nbd/share/trimmomatic-0.39-2/adapters/TruSeq3-PE-2.fa
# ./mambaforge/envs/nbd/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa
# ./mambaforge/envs/nbd/share/trimmomatic-0.39-2/adapters/TruSeq3-SE.fa
# ./mambaforge/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/NexteraPE-PE.fa
# ./mambaforge/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/TruSeq2-PE.fa
# ./mambaforge/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/TruSeq2-SE.fa
# ./mambaforge/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/TruSeq3-PE-2.fa
# ./mambaforge/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/TruSeq3-PE.fa
# ./mambaforge/pkgs/trimmomatic-0.39-hdfd78af_2/share/trimmomatic-0.39-2/adapters/TruSeq3-SE.fa