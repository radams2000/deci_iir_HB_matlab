close all;
clear all;
X0 = [0.14,0.14,0.044];
X = fminsearch(@findbest_df,X0) ;

X
