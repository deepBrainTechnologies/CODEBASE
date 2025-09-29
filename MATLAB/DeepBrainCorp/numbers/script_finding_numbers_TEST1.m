%script_finding_numbers_TEST1

cd('D:\DEEPBRAINTECHNOLOGIES\DATASETS\NUMBERS');
numbers = imread('OneToZero_Column.png');

numbers = numbers(:,:,1);

%images are to be in black and white
histVals = histogram(cast(numbers,'double'),20); %taking black and whites
logical=(numbers>100);
numbinario = (not(logical))*256 + logical*0; 
imagesc(numbinario); axis equal;

finding_x = sum(numbinario,1);
finding_y = sum(numbinario,2);

figure;
subplot(1,3,1)
imagesc(numbinario); axis equal;
subplot(1,3,2),
plot(finding_y,1:1:size(numbers,1));


figure;
subplot(2,1,1)
imagesc(numbinario); axis equal;
subplot(2,1,2),
plot(1:1:size(numbers,2),finding_x);
