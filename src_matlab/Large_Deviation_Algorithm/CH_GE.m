function R_M=CH_GE(R_M,pr,size1,size2,size3)
%This function is designed to modify the random number matrix, which is used to advance the Markov Chain Monte Carlo process. 
% Input: R_M is a random matrix, pr is the percentage change of the random matrix, and size1, 2, 3 represent the dimensions of R_M. 
% Output: The new random matrix R_M.
R_My=R_M;
R_My(randperm(size1*size3*size2,ceil(pr*size1*size2*size3)))=rand(ceil(pr*size1*size2*size3),1);
R_M=R_My;
