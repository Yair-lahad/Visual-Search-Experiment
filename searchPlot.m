function searchPlot(sizes,meanTarget,meanNon,stdTarget,stdNon)
% Paper parameters
paper_width     = 16.5; %cm
figure_ratio    =0.9;

% Set font parameters
labels_fontsize = 10;
round_value=2;

%% Calculation section

% correlation between set size to RT in all conditions
[r,p] = corr(sizes',[meanTarget' meanNon']); 
%fit function for each condition
fit_target_feature = polyfit(sizes,meanTarget(1,:),1);
fit_target_conj = polyfit(sizes,meanTarget(2,:),1);
fit_non_feature = polyfit(sizes,meanNon(1,:),1);
fit_non_conj = polyfit(sizes,meanNon(2,:),1);

%% Plotting
figure ('Color', 'w', 'Units', 'centimeters', 'Position', [1 1 paper_width figure_ratio*paper_width]); hold on; 

% with target
subplot 211;
errorbar(sizes,meanTarget(1,:),stdTarget(1,:),'ro-');
hold on;
plot(sizes,polyval(fit_target_feature,sizes),'r--');
errorbar(sizes,meanTarget(2,:),stdTarget(2,:),'bo-');
plot(sizes,polyval(fit_target_conj,sizes),'b--');
legend('Feature',['Feat. Fit, slope = ' num2str(round(fit_target_feature(1),round_value+1))] ,'Conjunction',['Conj. Fit, slope = ' num2str(round(fit_target_conj(1),round_value))],'Location','northwest','NumColumns', 2);
title(sprintf(['Target Present\nFeat. R = ' num2str(round(r(1),round_value)) ' (p = ' num2str(round(p(1),round_value)) '), Conj. R = ' num2str(round(r(2),round_value)) ' (p = ' num2str(round(p(1),round_value)) ')']));
ytop=max(meanTarget(2,:))+3*max(stdTarget(2,:));
ybot=min(meanTarget(1,:))-2*max(stdTarget(1,:));
ylim([ybot ytop]);
xlabel('Set Size','FontSize', labels_fontsize);
ylabel('Mean Reaction Time [sec]','FontSize', labels_fontsize);

%without target
subplot 212;
errorbar(sizes,meanNon(1,:),stdNon(1,:),'ro-')
hold on;
plot(sizes,polyval(fit_non_feature,sizes),'r--');
errorbar(sizes,meanNon(2,:),stdNon(2,:),'bo-');
plot(sizes,polyval(fit_non_conj,sizes),'b--');
legend('Feature',['Feat. Fit, slope = ' num2str(round(fit_non_feature(1),round_value))] ,'Conjunction',['Conj.n Fit, slope = ' num2str(round(fit_non_conj(1),round_value))],'Location','northwest', 'NumColumns', 2);
title(sprintf(['Target Absent\nFeat. R = ' num2str(round(r(3),round_value)) ' (p = ' num2str(round(p(3),round_value)) '), Conj. R = ' num2str(round(r(4),round_value)) ' (p = ' num2str(round(p(4),round_value)) ')']));
ytop2=max(meanNon(2,:))+3*max(stdNon(2,:));
ybot2=min(meanNon(1,:))-2*max(stdNon(1,:));
ylim([ybot2 ytop2]);
xlabel('Set Size','FontSize', labels_fontsize);
ylabel('Mean Reaction Time [sec]','FontSize', labels_fontsize);
end