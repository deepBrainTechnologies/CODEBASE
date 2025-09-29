% ___________________________________________________________
%    script_testing_delay_lines_for_image_processing
%
%
%____________________________________________________________

PATH_TO_IMAGES = 'D:\DEEPBRAINTECHNOLOGIES\DATASETS\WEATHER\LONDON\2024'
cd(PATH_TO_IMAGES)

thisIMAGE = imread('jan_2024_googleA.png');

Curve = thisIMAGE(:,:,1);
hist(cast(Curve,'double'));
Curve(Curve<50) = 0;
Curve(Curve>50) = 100;
imagesc(Curve)



