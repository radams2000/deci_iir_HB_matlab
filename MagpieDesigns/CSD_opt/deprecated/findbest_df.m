function peak_oob = findbest_df(x)

df0 = x(1);
df1 = x(2);
df2 = x(3);

fs = 384e3;
numsamples = 65536;
t = 0:1/fs:(numsamples-1)/fs;
numfreqs = 2048;
freqs = linspace(1000,fs/2,numfreqs);


% **************** section 1*************
F3db=0.25;
[n1,d1,n0,d0]=apellip_du(3,F3db-df0,F3db+df0); % d's are denominator


H0 = abs(0.5*(freqz(n1,d1,freqs,fs) + freqz(n0,d0,freqs,fs)));


%  ******************  section 2 ***************
fs = 192e3;
F3db=0.25;
% df=0.14;


[n1,d1,n0,d0]=apellip_du(3,F3db-df1,F3db+df1); % d's are denominator

H1 = abs(0.5*(freqz(n1,d1,freqs,fs) + freqz(n0,d0,freqs,fs)));


% *********************** section 3 ****************
fs = 96e3;
F3db=0.25;

[n1,d1,n0,d0]=apellip_du(7,F3db-df2,F3db+df2); % d's are denominator

H2 = abs(0.5*(freqz(n1,d1,freqs,fs) + freqz(n0,d0,freqs,fs)));

Htotal = H0.*H1.*H2;
fi = find(freqs > 28e3,1);
peak_oob = max(Htotal(fi:end));
peak_oob



