%script_test_tablesNUMS_histograms

imageFolder = 'D:\MYSOFTWAREBASE\MATLAB\DeepBrainCorp\imageToTableAP\images\';

tableIM = imread([imageFolder '\Boston_January2024.png']);

tableIM = tableIM(:,:,1);

%images are to be in black and white
histVals = histogram(cast(tableIM,'double'),20); %taking black and whites
logical=(tableIM>100);
numbinario = (not(logical))*256 + logical*0; 
imagesc(numbinario); axis equal;

finding_x = sum(numbinario,1);  %to find vertical lines
finding_y = sum(numbinario,2);  %to find horizontal lines

vertLineTH = max(finding_x)*0.8;
horLineTH  = max(finding_y)*0.8;

x_lines = finding_x>vertLineTH;
y_lines = finding_y>horLineTH;




figure;
subplot(1,3,1)
imagesc(numbinario); axis equal;
subplot(1,3,2),
plot(y_lines,1:1:size(tableIM,1));


figure;
subplot(2,1,1)
imagesc(numbinario); axis equal;
subplot(2,1,2),
plot(1:1:size(tableIM,2),x_lines);