function [TCs, TCfits, paras] = getTC_Suite2P_epORI(stat,Fcell,FcellNeu,cycleLength);


for i = 1:length(Fcell);F(:,:,i) = (Fcell{i});end
for i = 1:length(Fcell);Fnp(:,:,i) = (FcellNeu{i});end

if rem(length(F),cycleLength)~=0
    error('CycleLength is not consistent with data size');
end
nCycles = length(F)/cycleLength;
theta = 0:360/(nCycles-1):359;
for i = 1:size(F,1)
    traces = squeeze(F(i,:,:));
    trace = median(traces,2);
    F0 = mean(trace(1:cycleLength));
    dFF = (trace-F0)./F0;
    cycleResp = reshape(dFF,cycleLength,nCycles);
    TC = max(cycleResp(1:cycleLength/2,:))-median(cycleResp(end-4:end,:));
    pars = fitori(theta',TC(2:end));
    TCfit = oritune(pars,0:359);
    
    TCs(i,:) = TC;
    paras(i,:) = pars;
    TCfits(i,:) = TCfit;
end

    

