close all;
clear all;

j0=0;
j1=0;
j2=0;
ap_state_stage0_zm1=0; % 1st number os decimation stage
ap_state_stage0_zm0=0;

ap_state_stage1_zm1=0; % 1st number os decimation stage
ap_state_stage1_zm0=0;

ap_state_stage2_zm2=0;
ap_state_stage2_zm1=0; % 1st number os decimation stage
ap_state_stage2_zm0=0;

ap_state_stage2_del_zm1=0; % 1st number os decimation stage
ap_state_stage2_del_zm0=0;

deci_stage0_out0 = 0;
deci_stage0_out1 = 0;
deci_stage0_out2 = 0;
deci_stage0_out3 = 0;

deci_stage1_out0 = 0;
deci_stage1_out1 = 0;

deci_stage2_out0 = 0;

%dmaDestBuff_32bit = zeros(8256,1);
fs=384e3;
tt = 0:1/fs:8255/fs;


dmaDestBuff_32bit = sin(2*pi*29.2e3*tt);

deci_stage0_out_left = zeros(8256/2,1);
deci_stage1_out_left = zeros(8256/4,1);
deci_stage2_out_left = zeros(8256/8,1);

num0 = [0.1117    0.9436    1.0000];
denom0 = [ 1.0000    0.9436    0.1117];

num1 = [0.4521    1.0000];
denom1 = [1.0000    0.4521];


k = 8256/8;
j0 = 1+1; % allpass starts with odd inputs and skips by 2
j1 = 0+1; % output pointer into array
while(k > 0)  % each loop produces 2 outputs at 2X rate, so use DMALEN/8

	% 1st shift the zm1 to zm0 based on the current zm1 value
	ap_state_stage0_zm1 = ap_state_stage0_zm0;
	ap_state_stage0_zm0 = (dmaDestBuff_32bit(j0) /2) - (ap_state_stage0_zm1 /4) - (ap_state_stage0_zm1 /8); % scale input by 1/2 so the output does not need to be scaled by 1/2
	deci_stage0_out0 = ap_state_stage0_zm1 + (ap_state_stage0_zm0 /4) + (ap_state_stage0_zm0 /8) + 0.5*dmaDestBuff_32bit(j0-1);
	% deci_stage0_out_left(j1) = deci_stage0_out0 ;
    % j1 = j1 + 1;
	j0=j0+2;
	ap_state_stage0_zm1 = ap_state_stage0_zm0;
	ap_state_stage0_zm0 = (dmaDestBuff_32bit(j0) /2) - (ap_state_stage0_zm1 /4) - (ap_state_stage0_zm1 /8); % scale input by 1/2 so the output does not need to be scaled by 1/2
	deci_stage0_out1 = ap_state_stage0_zm1 + (ap_state_stage0_zm0 /4) + (ap_state_stage0_zm0 /8) + 0.5*dmaDestBuff_32bit(j0-1);
	% deci_stage0_out_left(j1) = deci_stage0_out1 ;
    % j1 = j1 + 1;

	j0=j0+2;
	ap_state_stage0_zm1 = ap_state_stage0_zm0;
	ap_state_stage0_zm0 = (dmaDestBuff_32bit(j0) /2) - (ap_state_stage0_zm1 /4) - (ap_state_stage0_zm1 /8); % scale input by 1/2 so the output does not need to be scaled by 1/2
	deci_stage0_out2 = ap_state_stage0_zm1 + (ap_state_stage0_zm0 /4) + (ap_state_stage0_zm0 /8) + 0.5*dmaDestBuff_32bit(j0-1);
	% deci_stage0_out_left(j1) = deci_stage0_out2 ;
    % j1 = j1 + 1;

	j0=j0+2;
	ap_state_stage0_zm1 = ap_state_stage0_zm0;
	ap_state_stage0_zm0 = (dmaDestBuff_32bit(j0) /2) - (ap_state_stage0_zm1 /4) - (ap_state_stage0_zm1 /8); % scale input by 1/2 so the output does not need to be scaled by 1/2
	deci_stage0_out3 = ap_state_stage0_zm1 + (ap_state_stage0_zm0 /4) + (ap_state_stage0_zm0 /8) + 0.5*dmaDestBuff_32bit(j0-1);
	% deci_stage0_out_left(j1) = deci_stage0_out3 ;
    % j1 = j1 + 1;

	j0=j0+2;

    %  4 outputs from 8 inputs here

    ap_state_stage1_zm1 = ap_state_stage1_zm0;
	ap_state_stage1_zm0 = (deci_stage0_out1 /2) - (ap_state_stage1_zm1 /4) - (ap_state_stage1_zm1 /8); % scale input by 1/2 so the output does not need to be scaled by 1/2
	deci_stage1_out0 = ap_state_stage1_zm1 + (ap_state_stage1_zm0 /4) + (ap_state_stage1_zm0 /8) + (deci_stage0_out0 /2);
    % deci_stage1_out_left(j1) = ap_state_stage1_zm1 + (ap_state_stage1_zm0 /4) + (ap_state_stage1_zm0 /8) + (deci_stage0_out0 /2);
	% j1 = j1 + 1;
    %deci_stage1_out_left
	
    ap_state_stage1_zm1 = ap_state_stage1_zm0;
	ap_state_stage1_zm0 = (deci_stage0_out3 /2) - (ap_state_stage1_zm1 /4) - (ap_state_stage1_zm1 /8); % scale input by 1/2 so the output does not need to be scaled by 1/2
	deci_stage1_out1 = ap_state_stage1_zm1 + (ap_state_stage1_zm0 /4) + (ap_state_stage1_zm0 /8) + (deci_stage0_out2 /2);

    % deci_stage1_out_left(j1) = ap_state_stage1_zm1 + (ap_state_stage1_zm0 /4) + (ap_state_stage1_zm0 /8) + (deci_stage0_out2 /2);
	%j1=j1+1;


    % at this point I've processed 8 inputs from the dma array and produced 2 outputs

    % now for the final stage. Top branch is a 2nd-order alppass num0/denom0, bottom
    % delayed branch is a 1st-order allpass, num1/denom1

    ap_state_stage2_zm2 = ap_state_stage2_zm1;
    ap_state_stage2_zm1 = ap_state_stage2_zm0;
    ap_state_stage2_zm0 = (deci_stage1_out1 /2) - denom0(2)*ap_state_stage2_zm1 - denom0(3)*ap_state_stage2_zm2;
    % note num(1) = denom(3), num(2) = denom(2)
    %allpass_upper = ap_state_stage2_zm0*num0(1) + ap_state_stage2_zm1*num0(2) + ap_state_stage2_zm2*1;
    allpass_upper = ap_state_stage2_zm0*denom0(3) + ap_state_stage2_zm1*denom0(2) + ap_state_stage2_zm2*1;

    ap_state_stage2_del_zm1 = ap_state_stage2_del_zm0;
    ap_state_stage2_del_zm0 = (deci_stage1_out0 /2) - denom1(2)*ap_state_stage2_del_zm1;
    % note num1(1) = denom1(2)
    allpass_lower = ap_state_stage2_del_zm0*denom1(2) + ap_state_stage2_del_zm1*1;
    deci_stage2_out_left(j1) = allpass_lower+allpass_upper;
    j1 = j1+1;

	k=k-1;

end

x = floor((2^31)*denom0(3));
fprintf('2nd-order upper-path coeff of z^-2 feedback (subtracted)  and z^0 feed-forward (added) = %f %s\n',denom0(3),dec2hex(x,8));
x = floor((2^31)*denom0(2));
fprintf('2nd-order upper-path coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = %f %s\n',denom0(2),dec2hex(x,8));

x = floor((2^31)*denom1(2));
fprintf('1st-order upper-path coeff of z^-1 feedback (subtracted)  and z^-1 feed-forward (added) = %f %s\n',denom1(2),dec2hex(x,8));



figure;
plot(deci_stage2_out_left);
