# tools_assemble
Scripts useful for analysing outputs for assemble method 

#usage

(1) First step is to generate input files in INPUT dir
    ./generate
    ./run
    
(2) Run simulations in DATA
    ./do_for
    ./gen_for
    ./run_for
    When simulations are finished collect results
    sbatch cal_for
    ./collect
(3) To analyse results in RESULTS
    ./cal_for
(4) Collect results to FINAL
    ./collect