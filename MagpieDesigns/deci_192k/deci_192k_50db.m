close all;
clear all;

addpath('..\..\allpassToolbox');

fs = 384e3;
numsamples = 65536;
t = 0:1/fs:(numsamples-1)/fs;
numfreqs = 2048;
freqs = linspace(1000,fs/2,numfreqs);





% *********************** section 1 ****************
fs = 384e3;
F3db=0.25;
% df=0.044;
df=0.047047;
% n1,d1 go with the delayed branch, 1st-order
% n0,d0 is the non-delayed branch, 2nd order
[n1_2,d1_2,n0_2,d0_2]=apellip_du(7,F3db-df,F3db+df); % d's are denominator


x = floor((2^31)*d0_2(5));
fprintf('\n\n ****final stage coeffs **** \n');
fprintf('2nd-order upper-path coeff of z^-2 feedback (subtracted)  and z^0 feed-forward (added) = %f %s\n',d0_2(5),dec2hex(x,8));
x = floor((2^31)*d0_2(3));
fprintf('2nd-order upper-path coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = %f %s\n',d0_2(3),dec2hex(x,8));

x = floor((2^31)*d1_2(3));
fprintf('1st-order upper-path coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = %f %s\n',d1_2(3),dec2hex(x,8));

%[a,p,n]=csdigit(n1_2(2),0,8);
H2 = abs(0.5*(freqz(n1_2,d1_2,freqs,fs) + freqz(n0_2,d0_2,freqs,fs)));

Htotal = H2;
fi = find(freqs > 28e3,1);
peak_oob = max(Htotal(fi:end));

figure;
plot(freqs,20*log10(abs(Htotal)));
title('response before dec ');
ylim([-70 0]);




