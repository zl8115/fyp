close all, clear all

load("SharpData.mat");

comparisonSet = {Trial3,Speed3,Speed4};

clearvars -except comparisonSet;

figure; 
subplot(2,1,1); hold on;
for i = 1:length(comparisonSet)
    plot(comparisonSet{i}.nameList,comparisonSet{i}.sharp1);
    leg{i} = sprintf('Dataset %i',i);
end
grid on; grid minor;
title('Sharp 1 Comparison');
xlabel('Lens Tuning (mA)');
ylabel('Sharpness Measure (AU)');
legend(leg)

subplot(2,1,2); hold on;
for i = 1:length(comparisonSet)
    plot(comparisonSet{i}.nameList,comparisonSet{i}.sharp2);
end
grid on; grid minor;
title('Sharp 2 Comparison');
xlabel('Lens Tuning (mA)');
ylabel('Sharpness Measure (AU)');
legend(leg)


%%
getVarName(comparisonSet{1})

function out = getVarName(var)
    out = inputname(1);
end