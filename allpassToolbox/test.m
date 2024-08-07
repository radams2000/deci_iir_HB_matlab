close all;
clear all;

F3db=0.25;
df=0.2214;

x = zeros(2048,1);
x(1) =  1;
[n1,d1,n0,d0]=apellip_du(3,F3db-df,F3db+df); % d's are denominator
fvtool((filter(n0,d0,x)+filter(n1,d1,x))/2);


% time donain sim

% decimated coefficients
num = [n0(1), n0(3)];
num(1) = 0.25; % over-ride ideal; modify for shift-only multiply; stopband at 172KHz is 48 dB
denom = [d0(1),d0(3)];

fs = 384e3;
numsamples = 65536;
t = 0:1/fs:(numsamples-1)/fs;
numfreqs = 256;
freqs = linspace(1000,fs/2,numfreqs);
yrms = zeros(numfreqs,1);

for k = 1:numfreqs
    vin = sin(2*pi*freqs(k)*t);
    vin_even = vin(1:2:end);
    vin_odd = vin(2:2:end);
    num = [n0(1), n0(3)];
    denom = [d0(1),d0(3)];
    y1 = filter(num,denom,vin_odd); % the odds are least-delayed
    y2 = vin_even; % the evens are delayed; remember it goes from olest:newest
    y = 0.5*(y1 + y2);
    yrms(k) = 1.414*rms(y);
end
figure;
plot(freqs,20*log10(yrms));
ylim([-70 0]);

