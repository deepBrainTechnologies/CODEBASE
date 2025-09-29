%script_plot_SCALED_january_2024.m

figuresDIR='D:\DEEPBRAINTECHNOLOGIES\DATASETS\FIGURES\';
load('D:\DEEPBRAINTECHNOLOGIES\DATASETS\DATA_TO_PLOT.mat')
mkdir(figuresDIR);

dataNVIDIA(:,5)= tool_rescale_data(dataNVIDIA(:,5));
dataBOEING(:,5)= tool_rescale_data(dataBOEING(:,5));
dataHITACHI(:,5)= tool_rescale_data(dataHITACHI(:,5));
dataVODAFONE(:,5)= tool_rescale_data(dataVODAFONE(:,5));
dataJFK(:,3)= tool_rescale_data(dataJFK(:,3));

figI=figure;
scatter(dataNVIDIA(:,1),dataNVIDIA(:,5),'*','LineWidth',3); hold all;
scatter(dataBOEING(:,1),dataBOEING(:,5)+1,'*','LineWidth',3); hold all;
scatter(dataHITACHI(:,1),dataHITACHI(:,5)+2,'*','LineWidth',3); hold all;
scatter(dataVODAFONE(:,1),dataVODAFONE(:,5)+3,'*','LineWidth',3); hold all;

legend('Nvidia','Boeing','Hitachi','Vodafone');

xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
yticks([0 100 200 300]);
yticklabels({'0' '100' '200' '300'});
set(gca, 'LineWidth', 2);
set(gca, 'FontSize', 12);
saveas(figI,[figuresDIR '\January_2024_RESCALED_SHIFTED_Boeing_Nvidia_Hitachi_Vodafone.png']);


fig2 = figure;
subplot(2,2,1)
scatter(dataJFK(:,3),dataVODAFONE(:,5),'*','LineWidth',3); hold all; axis equal;
xlabel('JFK mean T° versus Vodafone');axis square;
subplot(2,2,2)
scatter(dataJFK(:,3),dataBOEING(:,5),'*','LineWidth',3); hold all;axis equal;
xlabel('JFK mean T° versus Boeing');axis square;
subplot(2,2,3)
scatter(dataJFK(:,3),dataNVIDIA(:,5),'*','LineWidth',3); hold all;axis equal;
xlabel('JFK mean T°  versus Nvidia');axis square;
subplot(2,2,4)
scatter(dataJFK(:,3),dataHITACHI(:,5),'*','LineWidth',3); hold all;axis equal;
xlabel('JFK mean T° versus Hitachi');axis square;
saveas(fig2, [figuresDIR '\January_2024_RESCALED_TemperatureJFK_versus_Shares.png']);



fig3=figure;
subplot(2,2,1)
scatter(dataJFK(:,1),dataJFK(:,3)+1,'*k','LineWidth',3); hold all; 
scatter(dataNVIDIA(:,1),dataNVIDIA(:,5),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Nvidia ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
subplot(2,2,2)
scatter(dataJFK(:,1),dataJFK(:,3)+1,'*k','LineWidth',3); hold all; 
scatter(dataHITACHI(:,1),dataHITACHI(:,5),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Hitachi ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
subplot(2,2,3)
scatter(dataJFK(:,1),dataJFK(:,3)+1,'*k','LineWidth',3); hold all; 
scatter(dataBOEING(:,1),dataBOEING(:,5),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Boeing ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
subplot(2,2,4)
scatter(dataJFK(:,1),dataJFK(:,3)+1,'*k','LineWidth',3); hold all; 
scatter(dataVODAFONE(:,1),dataVODAFONE(:,5),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Vodafone');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});

saveas(fig3, [figuresDIR '\January_2024_RESCALED_SHIFTED_JFKmeanTemp_versus_StockOpenPrice.png']);



