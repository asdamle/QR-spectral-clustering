README
=====================

This code implements the methodology presented in

Anil Damle, Victor Minden, Lexing Ying, "Robust and efficient multi-way spectral clustering," [arXiv:1609.08251](http://arxiv.org/abs/1609.08251)


The file SBM_example.m contains a commented demonstrative example using the included routines to perform spectral clustering for the stochastic block model. The file spectral_cluster.m takes an adjacency matrix A and performs spectral clustering to find k clusters with or without degree normalization. The subroutines clusterQR.m and clusterQR_random.m implement the clustering methodology (the latter being the randomized variant) in the paper but do not actually perform the cluster assignment step. 