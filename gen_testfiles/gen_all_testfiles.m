% generate test files
close all;
clear all;


dmaSize = 8256;
testData = zeros(dmaSize,1);
fs = 384e3;

df = fs/dmaSize; % all exact multiples of df will be continuous across the block boundary
tend = (dmaSize-1)/fs;
tt = 0:(1/fs):tend;
tt = tt';


% 16 KHz
delta = (24e3-20e3)/48e3; % ratiomaetric
fsout = 16e3;
fpass = fsout/2*(1 - delta);
fstop = fsout/2*(1 + delta);
fpassTest = df*floor(fpass/df);
vin_pbedge = sin(2*pi*fpassTest*tt); % sine wave at passband edge

v_outofband = zeros(dmaSize,1);
deltaF = (192e3-fstop)/16; % limit to 16 components in the alias-test stopband
for f=fstop+500:deltaF:192e3-500
    ftest = df*floor(f/df);
    v_outofband = v_outofband + sin(2*pi*ftest*tt + (rand(1,1)-0.5)*4*pi);
end

f1kTest = df*floor(1e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k


testData = vin_pbedge + vin_1k + v_outofband;
testData  = 0.99*testData/max(abs(testData));
testData = round((2^31)*testData);


fid = fopen('decimate_test_16k.txt','w');
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);


% 1K only

testData_1k = vin_1k;
testData_1k  = 0.99*testData_1k/max(abs(testData_1k));
testData_1k = round((2^31)*testData_1k);
fid = fopen('decimate_test_sin_1k.txt','w'); % good for all sample-rates
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData_1k(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);


% 20K only
f1kTest = df*floor(20e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k
testData_1k = vin_1k;
testData_1k  = 0.99*testData_1k/max(abs(testData_1k));
testData_1k = round((2^31)*testData_1k);
fid = fopen('decimate_test_sin_20k.txt','w'); % good for all sample-rates
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData_1k(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);

% 24 KHz
delta = (24e3-20e3)/48e3; % ratiomaetric
fsout = 24e3;
fpass = fsout/2*(1 - delta);
fstop = fsout/2*(1 + delta);
fpassTest = df*floor(fpass/df);
vin_pbedge = sin(2*pi*fpassTest*tt); % sine wave at passband edge
f1kTest = df*floor(1e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k
v_outofband = zeros(dmaSize,1);
deltaF = (192e3-fstop)/16; % limit to 16 components in the alias-test stopband
for f=fstop+500:deltaF:192e3-500
    ftest = df*floor(f/df);
    v_outofband = v_outofband + sin(2*pi*ftest*tt + (rand(1,1)-0.5)*4*pi);
end
testData = vin_pbedge + vin_1k + v_outofband;
testData  = 0.99*testData/max(abs(testData));
testData = round((2^31)*testData);
fid = fopen('decimate_test_24k.txt','w');
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);



% 32 KHz
delta = (24e3-20e3)/48e3; % ratiomaetric
fsout = 32e3;
fpass = fsout/2*(1 - delta);
fstop = fsout/2*(1 + delta);
fpassTest = df*floor(fpass/df);
vin_pbedge = sin(2*pi*fpassTest*tt); % sine wave at passband edge
f1kTest = df*floor(1e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k
v_outofband = zeros(dmaSize,1);
deltaF = (192e3-fstop)/16; % limit to 16 components in the alias-test stopband
for f=fstop+500:deltaF:192e3-500
ftest = df*floor(f/df);
    v_outofband = v_outofband + sin(2*pi*ftest*tt + (rand(1,1)-0.5)*4*pi);
end
testData = vin_pbedge + vin_1k + v_outofband;
testData  = 0.99*testData/max(abs(testData));
testData = round((2^31)*testData);
fid = fopen('decimate_test_32k.txt','w');
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);




% 48 KHz
delta = (24e3-20e3)/48e3; % ratiomaetric
fsout = 48e3;
fpass = fsout/2*(1 - delta);
fstop = fsout/2*(1 + delta);
fpassTest = df*floor(fpass/df);
vin_pbedge = sin(2*pi*fpassTest*tt); % sine wave at passband edge
f1kTest = df*floor(1e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k
v_outofband = zeros(dmaSize,1);
deltaF = (192e3-fstop)/16; % limit to 16 components in the alias-test stopband
for f=fstop+500:deltaF:192e3-500
    ftest = df*floor(f/df);
    v_outofband = v_outofband + sin(2*pi*ftest*tt + (rand(1,1)-0.5)*4*pi);
end
testData = vin_pbedge + vin_1k + v_outofband;
testData  = 0.99*testData/max(abs(testData));
testData = round((2^31)*testData);
fid = fopen('decimate_test_48k.txt','w');
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);


% 96 KHz
delta = (24e3-20e3)/48e3; % ratiomaetric
fsout = 96e3;
fpass = fsout/2*(1 - delta);
fstop = fsout/2*(1 + delta);
fpassTest = df*floor(fpass/df);
vin_pbedge = sin(2*pi*fpassTest*tt); % sine wave at passband edge
f1kTest = df*floor(1e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k
v_outofband = zeros(dmaSize,1);
deltaF = (192e3-fstop)/16; % limit to 16 components in the alias-test stopband
for f=fstop+500:deltaF:192e3-500
    ftest = df*floor(f/df);
    v_outofband = v_outofband + sin(2*pi*ftest*tt + (rand(1,1)-0.5)*4*pi);
end
testData = vin_pbedge + vin_1k + v_outofband;
testData  = 0.99*testData/max(abs(testData));
testData = round((2^31)*testData);
fid = fopen('decimate_test_96k.txt','w');
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);




% 192 KHz
delta = (24e3-20e3)/48e3; % ratiomaetric
fsout = 192e3;
fpass = fsout/2*(1 - delta);
fstop = fsout/2*(1 + delta);
fpassTest = df*floor(fpass/df);
vin_pbedge = sin(2*pi*fpassTest*tt); % sine wave at passband edge
f1kTest = df*floor(1e3/df);
vin_1k = sin(2*pi*f1kTest*tt); % sine wave aaround 1k
deltaF = (192e3-fstop)/16; % limit to 16 components in the alias-test stopband
v_outofband = zeros(dmaSize,1);
for f=fstop+500:deltaF:192e3-500
    ftest = df*floor(f/df);
    %ftest
    v_outofband = v_outofband + sin(2*pi*ftest*tt + (rand(1,1)-0.5)*4*pi);
end
testData = vin_pbedge + vin_1k + v_outofband;
testData  = 0.99*testData/max(abs(testData));
testData = round((2^31)*testData);
fid = fopen('decimate_test_192k.txt','w');
fprintf(fid,'static q31_t dmaDestBuff_32bit[DMA_buffLen] = {\n');
fprintf(fid,'%d, ',testData(1:end-1));
fprintf(fid,'%d',testData(end));
fprintf(fid,'};\n\n');
fclose(fid);
