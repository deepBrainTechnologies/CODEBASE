%script_fit_SharesModel_from_WEEKLY_WEATHER_hitachi.m

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


%fitting model only on Hitachi and Hitachi
jfk = dataJFK(:,3);
thisDates = dataJFK(:,1);

hitachi = dataHITACHI(:,4);

figI=figure;
%for each week we generate a model based on linear estimator
for ii=1:1:(length(mondaysList)-1)
  whichDays = mondaysList(ii):1:(mondaysList(ii)+6);
  whichDays = tool_ReturnFoundElements(thisDates, whichDays);
  
  thisTemp= jfk(whichDays>0);
  thisHitachi = hitachi(whichDays>0);
  
  
  %remove nans and zeros
  whichKeep = ~isnan(thisHitachi);
  thisTemp = thisTemp(whichKeep);
  thisHitachi = thisHitachi(whichKeep);
 
  
  
  DeltaTemp = diff(thisTemp);
  DeltaHitachi= diff(thisHitachi);
  
  for dd=1:1:length(DeltaTemp)
    aa = DeltaHitachi(1:dd)./DeltaTemp(1:dd);
    meanAA(ii,dd) = mean(aa);
    stdAA(ii,dd) = std(aa);
    
    AAofminerror(ii,dd) = sum(DeltaHitachi(1:dd).*DeltaTemp(1:dd))./(sum((DeltaTemp(1:dd)).^2));
    
    subplot(2,2,ii);
    scatter(dd,thisHitachi(dd)+AAofminerror(ii,dd)*DeltaTemp(dd),'*k','LineWidth', 2);hold all;
    scatter(dd,thisHitachi(dd)+meanAA(ii,dd)*DeltaTemp(dd),'rs','LineWidth', 2); hold all;
    scatter(dd,thisHitachi(dd)+(meanAA(ii,dd)-stdAA(ii,dd))*DeltaTemp(dd),'rs','LineWidth', 2); hold all;
    scatter(dd,thisHitachi(dd)+(meanAA(ii,dd)+stdAA(ii,dd))*DeltaTemp(dd),'rs','LineWidth', 2); hold all;
    scatter(dd,thisHitachi(dd+1),'db','LineWidth', 2);
    xlabel(sprintf('Hitachi week %d', ii));
    set(gca, 'LineWidth', 2);
    set(gca, 'FontSize', 12);
  end
  
  
end

saveas(figI,[figuresDIR '/Hitachi_Generative_SharePredictor_Jan2024.png']);
