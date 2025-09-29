%script_fit_SharesModel_from_WEEKLY_WEATHER_nvidia.m

figuresDIR='D:\DEEPBRAINTECHNOLOGIES\DATASETS\FIGURES\';
load('D:\DEEPBRAINTECHNOLOGIES\DATASETS\DATA_TO_PLOT.mat')
mkdir(figuresDIR);

dataNVIDIA(:,4)= tool_rescale_data(dataNVIDIA(:,4));
dataBOEING(:,4)= tool_rescale_data(dataBOEING(:,4));
dataHITACHI(:,4)= tool_rescale_data(dataHITACHI(:,4));
dataVODAFONE(:,4)= tool_rescale_data(dataVODAFONE(:,4));

dataJFK(:,3)= tool_rescale_data(dataJFK(:,3));
mondaysList = datenum(['01,Jan,2024';'08,Jan,2024'; '15,Jan,2024'; ...
                          '22,Jan,2024' ;'29,Jan,2024']);


%fitting model only on Nvidia and Boeing
jfk = dataJFK(:,3);
thisDates = dataJFK(:,1);

nvidia = dataNVIDIA(:,4);
figI = figure;

%for each week we generate a model based on linear estimator
for ii=1:1:(length(mondaysList)-1)
  whichDays = mondaysList(ii):1:(mondaysList(ii)+6);
  whichDays = tool_ReturnFoundElements(thisDates, whichDays);
  
  thisTemp= jfk(whichDays>0);
  thisNvidia = nvidia(whichDays>0);
  
  
  %remove nans and zeros
  whichKeep = ~isnan(thisNvidia);
  thisTemp = thisTemp(whichKeep);
  thisNvidia = thisNvidia(whichKeep);
 
  
  
  DeltaTemp = diff(thisTemp);
  DeltaNvidia= diff(thisNvidia);
  
  for dd=1:1:length(DeltaTemp)
    aa = DeltaNvidia(1:dd)./DeltaTemp(1:dd);
    meanAA(ii,dd) = mean(aa);
    stdAA(ii,dd) = std(aa);
    
    AAofminerror(ii,dd) = sum(DeltaNvidia(1:dd).*DeltaTemp(1:dd))./(sum((DeltaTemp(1:dd)).^2));
    
    subplot(2,2,ii);
    scatter(dd,thisNvidia(dd)+AAofminerror(ii,dd)*DeltaTemp(dd),'*k','LineWidth', 2);hold all;
    scatter(dd,thisNvidia(dd)+meanAA(ii,dd)*DeltaTemp(dd),'rs','LineWidth', 2); hold all;
    scatter(dd,thisNvidia(dd)+(meanAA(ii,dd)-stdAA(ii,dd))*DeltaTemp(dd),'rs','LineWidth', 2); hold all;
    scatter(dd,thisNvidia(dd)+(meanAA(ii,dd)+stdAA(ii,dd))*DeltaTemp(dd),'rs','LineWidth', 2); hold all;
    scatter(dd,thisNvidia(dd+1),'db','LineWidth', 2);
    xlabel(sprintf('Nvidia week %d', ii));
    set(gca, 'LineWidth', 2);
    set(gca, 'FontSize', 12);
  end
  
  
end

saveas(figI,[figuresDIR '/Nvidia_Generative_SharePredictor_Jan2024.png'])
