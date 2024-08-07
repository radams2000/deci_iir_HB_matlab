close all;
clear all;

addpath('..\..\allpassToolbox');

fs = 384e3;
numsamples = 65536;
t = 0:1/fs:(numsamples-1)/fs;
numfreqs = 2048;
freqs = linspace(1000,fs/2,numfreqs);




% **************** section 1*************
F3db=0.25;
% df=0.14;
df=0.19;
[n1_0,d1_0,n0_0,d0_0]=apellip_du(3,F3db-df,F3db+df); % d's are denominator


% modify for multiply-free (from csdigit.m)
 n0_0(1) = (1/4) + (1/16) + (1/32) ;
 d0_0(3) = n0_0(1);

H0 = abs(0.5*(freqz(n1_0,d1_0,freqs,fs) + freqz(n0_0,d0_0,freqs,fs)));
figure;
plot(freqs,20*log10(abs(H0)));
title('stage 0 ');
ylim([-70 0]);




% **************** section 2 same as section 1*************
fs = 192e3;
F3db=0.25;
% df=0.14;
df=0.19;
[n1_0,d1_0,n0_0,d0_0]=apellip_du(3,F3db-df,F3db+df); % d's are denominator
% modify for multiply-free
% n0_0(1) = 0.25 + 0.125 + (1/64);
% d0_0(3) = n0_0(1);

% modify for multiply-free (from csdigit.m)
 n0_0(1) = (1/4) + (1/16) + (1/32) ;
 d0_0(3) = n0_0(1);

H1 = abs(0.5*(freqz(n1_0,d1_0,freqs,fs) + freqz(n0_0,d0_0,freqs,fs)));
figure;
plot(freqs,20*log10(abs(H0)));
title('stage 0 ');
ylim([-70 0]);

% decimated coefficients
% num0_deci2 = [n0(1), n0(3)];
% denom0_deci2 = [d0(1),d0(3)];

%  ******************  section 3 ***************
fs = 96e3;
F3db=0.25;
% df=0.14;
df=0.128377;

[n1_1,d1_1,n0_1,d0_1]=apellip_du(5,F3db-df,F3db+df); % d's are denominator
% modify for multiply-free (from csdigit.m)

n0_1(1) = (1/8); % ideal 0.135920881853269
d0_1(3) = n0_1(1);
n1_1(2) = (1/2) + (1/16); % ideal 0.581277075666492
d1_1(3) = n1_1(2);

fprintf('\n\n ****middle stage CSD  stage **** \n');
fprintf('non-delayed 1st-order AP coeff of z^-1 feedback (subtracted)  and z^0 feed-forward (added) = (1/8) \n');

fprintf('delayed 1st-order AP coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = (1/2) + (1/16)\n');



H2 = abs(0.5*(freqz(n1_1,d1_1,freqs,fs) + freqz(n0_1,d0_1,freqs,fs)));
figure;
plot(freqs,20*log10(abs(H1)));
title('stage 1 ');
ylim([-70 0]);

% *********************** section 4 ****************
fs = 48e3;
F3db=0.25;
% df=0.044;
df=0.047047;
[n1_2,d1_2,n0_2,d0_2]=apellip_du(7,F3db-df,F3db+df); % d's are denominator


x = floor((2^31)*d0_2(5));
fprintf('\n\n ****final stage coeffs **** \n');
fprintf('2nd-order upper-path coeff of z^-2 feedback (subtracted)  and z^0 feed-forward (added) = %f %s\n',d0_2(5),dec2hex(x,8));
x = floor((2^31)*d0_2(3));
fprintf('2nd-order upper-path coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = %f %s\n',d0_2(3),dec2hex(x,8));

x = floor((2^31)*d1_2(3));
fprintf('1st-order upper-path coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = %f %s\n',d1_2(3),dec2hex(x,8));

%[a,p,n]=csdigit(n1_2(2),0,8);
H3 = abs(0.5*(freqz(n1_2,d1_2,freqs,fs) + freqz(n0_2,d0_2,freqs,fs)));
figure;
plot(freqs,20*log10(abs(H2)));
title('stage 2 ');
ylim([-70 0]);

Htotal = H0.*H1.*H2.*H3;

figure;
plot(freqs,20*log10(abs(Htotal)));
title('cascade all stages ');
ylim([-70 0]);




