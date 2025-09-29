%script_import_data_to_analyze_paper_JFK_singularity
SHAREPRICE_PATH = 'D:\DEEPBRAINTECHNOLOGIES\DATASETS\STOCKPRICES\';

WEATHER_PATH = 'D:\DEEPBRAINTECHNOLOGIES\DATASETS\WEATHER\USA';

companies = {'nvidia','hitachi','boeing','vodafone'};
cities = {'JFK'};
months = {'January','April'};
years = {'2025','2024'};


%test first january 2024 --------------------------------------------------

filename = [SHAREPRICE_PATH '\hitachiSHARES\hitachi_january_2024.txt'];
[dataHITACHI, thisDateHITACHI]= load_share_prices_from_TXT_file_yahooFormat(filename);

filename = [SHAREPRICE_PATH '\boeingSHARES\boeing_january_2024.txt'];
[dataBOEING, thisDateBOEING]= load_share_prices_from_TXT_file_yahooFormat(filename);


filename = [SHAREPRICE_PATH '\vodafoneSHARES\vodafone_january_2024.txt'];
[dataVODAFONE, thisDateVODAFONE]= load_share_prices_from_TXT_file_yahooFormat(filename);

filename = [SHAREPRICE_PATH '\nvidiaSHARES\nvidia_january_2024.txt'];
[dataNVIDIA, thisDateNVIDIA]= load_share_prices_from_TXT_file_yahooFormat(filename);

%----- arrange all monthly data by date, fill the gaps with NaN  ----------

minDate = min([dataHITACHI(:,1); dataBOEING(:,1) ;dataVODAFONE(:,1) ;dataNVIDIA(:,1)]);
maxDate = max([dataHITACHI(:,1); dataBOEING(:,1) ;dataVODAFONE(:,1) ;dataNVIDIA(:,1)]);


dataHITACHI = tool_fillDatesGapsWithNANs(dataHITACHI, minDate,maxDate);
dataBOEING = tool_fillDatesGapsWithNANs(dataBOEING, minDate,maxDate);
dataVODAFONE = tool_fillDatesGapsWithNANs(dataVODAFONE, minDate,maxDate);
dataNVIDIA = tool_fillDatesGapsWithNANs(dataNVIDIA, minDate,maxDate);


filename = [WEATHER_PATH '\JFK_January2024.txt'];
[dataJFK, thisDateJFK]= load_weather_from_TXT_file_USA(filename);
dataJFK = tool_fillDatesGapsWithNANs(dataJFK, minDate,maxDate);

save('D:\DEEPBRAINTECHNOLOGIES\DATASETS\DATA_TO_PLOT.mat','dataHITACHI','dataBOEING',...
                                                         'dataVODAFONE','dataNVIDIA', 'dataJFK');








