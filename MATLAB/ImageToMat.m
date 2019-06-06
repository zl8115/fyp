close all, clear all

% Converts obtained .png files to .mat cells

% Folder and Image Variables
folder = 'Trial3';
lowerRange = -290;
upperRange = 290;
stepSize = 1;

% Static Settings
imageFolder = 'ImageSet';
imageExtension = '.png';

% Defines the imageDirectory and nameList
imageDirectory = strcat('./',imageFolder,'/',folder,'/');
nameList = [lowerRange:stepSize:upperRange];
clear imageFolder;

if isfolder(imageDirectory)    
    for i = 1:length(nameList)
        imageFile = strcat(imageDirectory,num2str(nameList(i)),imageExtension);
        imageFile_avr = strcat(imageDirectory,num2str(nameList(i)),'_avr',imageExtension);
        rawImage{i} = imread(imageFile);
        avrImage{i} = imread(imageFile_avr);
    end
    save(strcat('ImageMat',filesep,folder),'rawImage','avrImage','nameList');
    fprintf('Images Saved as %s.mat \n',folder);
else
    fprintf('Error! Image Directory does not Exist! \n');
end