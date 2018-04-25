Generating plots for "Simple, direct, and efficient multi-way spectral clustering"

gen_all_plots.m generates all of the plots and table data from the paper, though
it will take a long time to run due to generation of the phase plots. Details
and easier ways to generate specific plots follows.

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
      via real_data.m, which also outputs the entries of the table. Note that the
      values in the paper are reproducible by MATLAB 2015b, newer versions will
      generate quantitatively, though not qualitatively, different results due to   
      changes in built in functions (this only changes the numbers for k-means, not
      our algorithm). For example, the table is recreated below for MATLAB 2017b:

                                k-means objective         multi-way cut (3.1)
      k-means++ mean                1.48                      8.78
      k-means++ median              1.47                      10.44
      k-means++ min                 0.76                      1.86
      k-means++ max                 3.18                      42.03
      Algorithm 1                   2.52                      1.92
      k-means seeded with Alg 1     0.76                      1.86

      