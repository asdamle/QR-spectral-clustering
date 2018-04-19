Generating plots for "Simple, direct, and efficient multi-way spectral clustering"

Figure 1 is an illustration
 

Figures 2, 3, and 4:

    - The scripts "block_test_ab_sherlock.m" and "block_test_unequal.m" generate 
      the data for the phase plots. The former does equal sized blocks and the 
      latter does unequally sized blocks. Parameters such as the number of blocks,
      range of alpha and beta, size of blocks, etc. are set at the top of the file.
      Since these take a while to run, we have also included the data used in the
      paper in two .mat files, "9_block_test_sherlock.mat" and 
      "7_block_test_unequal.mat". Using these .mat files, all components of 
      Figures 2, 3, and 4 can be generated with gen_plots (loading the appropriate
      .mat file as noted in the comments)

Table 1
    - The data for Table 1 is stored in RealData_cluster.mat and can be generated   
      via real_data.m, which also outputs the entries of the table.