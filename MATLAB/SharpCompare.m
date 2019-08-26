close all, clear all

load("SharpData.mat");

comparisonSet = {Trial1,Trial2,Trial3};
sharpSet = [1:4];

clearvars -except comparisonSet sharpSet;

figure; 
for i = 1:length(sharpSet)
    subplot(length(sharpSet),1,i); hold on;
    for j = 1:length(comparisonSet)
        eval(sprintf('plot(comparisonSet{j}.nameList,comparisonSet{j}.sharp%i)',sharpSet(i)));
        leg{j} = sprintf('Dataset %i',j);
    end
    grid on; grid minor;
    title(sprintf('Sharp%i',sharpSet(i)));
    xlabel('Lens Tuning (mA)');
    ylabel('Sharpness Measure (AU)');
    legend(leg)
end