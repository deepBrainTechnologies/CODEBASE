%script_plot_january_2024.m

figuresDIR='D:\DEEPBRAINTECHNOLOGIES\DATASETS\FIGURES\';
load('D:\DEEPBRAINTECHNOLOGIES\DATASETS\DATA_TO_PLOT.mat')
mkdir(figuresDIR);

figI=figure;
scatter(dataNVIDIA(:,1),dataNVIDIA(:,4),'*','LineWidth',3); hold all;
scatter(dataBOEING(:,1),dataBOEING(:,4),'*','LineWidth',3); hold all;
scatter(dataHITACHI(:,1),dataHITACHI(:,4),'*','LineWidth',3); hold all;
scatter(dataVODAFONE(:,1),dataVODAFONE(:,4),'*','LineWidth',3); hold all;

legend('Nvidia','Boeing','Hitachi','Vodafone');

xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
yticks([0 100 200 300]);
yticklabels({'0' '100' '200' '300'});
set(gca, 'LineWidth', 2);
set(gca, 'FontSize', 12);
saveas(figI,[figuresDIR '\January_2024_Boeing_Nvidia_Hitachi_Vodafone.png']);


fig2 = figure;
subplot(3,3,1)
scatter(dataHITACHI(:,4),dataVODAFONE(:,4),'*','LineWidth',3); hold all; axis equal;
xlabel('Hitachi versus Vodafone');axis square;
subplot(3,3,2)
scatter(dataHITACHI(:,4),dataBOEING(:,4),'*','LineWidth',3); hold all;axis equal;
xlabel('Hitachi versus Boeing');axis square;
subplot(3,3,3)
scatter(dataHITACHI(:,4),dataNVIDIA(:,4),'*','LineWidth',3); hold all;axis equal;
xlabel('Hitachi versus Nvidia');axis square;
%saveas(figI2, [figuresDIR '\January_2024_Hitachi_versus_others.png']);


%figI3 = figure;
subplot(3,3,4)
scatter(dataNVIDIA(:,4),dataVODAFONE(:,4),'*','LineWidth',3); hold all; axis equal;
xlabel('Nvidia versus Vodafone');axis square;
subplot(3,3,5)
scatter(dataNVIDIA(:,4),dataBOEING(:,4),'*','LineWidth',3); hold all;axis equal;
xlabel('Nvidia versus Boeing');axis square;
subplot(3,3,6)
scatter(dataNVIDIA(:,4),dataHITACHI(:,4),'*','LineWidth',3); hold all;axis equal;
xlabel('Nvidia versus Hitachi');axis square;
%saveas(figI3, [figuresDIR '\January_2024_Nvidia_versus_others.png']);


%figI4 = figure;
subplot(3,3,7)
scatter(dataVODAFONE(:,4),dataNVIDIA(:,4),'*','LineWidth',3); hold all; axis equal;
xlabel(' Vodafone versus Nvidia');axis square;
subplot(3,3,8)
scatter(dataVODAFONE(:,4),dataBOEING(:,4),'*','LineWidth',3); hold all;axis equal;
xlabel('Vodafone versus Boeing');axis square;
subplot(3,3,9)
scatter(dataVODAFONE(:,4),dataHITACHI(:,4),'*','LineWidth',3); hold all;axis equal;
xlabel('Vodafone versus Hitachi'); axis square;
saveas(fig2, [figuresDIR '\January_2024_Nvidia_versus_others.png']);



fig3=figure;
subplot(2,2,1)
scatter(dataJFK(:,1),dataJFK(:,3),'*k','LineWidth',3); hold all; 
scatter(dataNVIDIA(:,1),dataNVIDIA(:,4),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Nvidia ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
subplot(2,2,2)
scatter(dataJFK(:,1),dataJFK(:,3),'*k','LineWidth',3); hold all; 
scatter(dataHITACHI(:,1),dataHITACHI(:,4),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Hitachi ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
subplot(2,2,3)
scatter(dataJFK(:,1),dataJFK(:,3),'*k','LineWidth',3); hold all; 
scatter(dataBOEING(:,1),dataBOEING(:,4),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Boeing ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});
subplot(2,2,4)
scatter(dataJFK(:,1),dataJFK(:,3),'*k','LineWidth',3); hold all; 
scatter(dataVODAFONE(:,1),dataVODAFONE(:,4),'*','LineWidth',3); hold all;
xlabel('JFK temperature and Vodafone ');
xticks([min(dataNVIDIA(:,1)) max(dataNVIDIA(:,1))]);
xticklabels({'1/Jan/2024' '31/01/2024'});

saveas(fig3, [figuresDIR '\January_2024_JFKmeanTemp_versus_StockOpenPrice.png']);



