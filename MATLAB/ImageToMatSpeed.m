close all, clear all

% Converts obtained .png files to .mat cells

% Folder and Image Variables
folder = 'Speed4';
lowerRange = -290;
upperRange = 290;
stepSize = 10;

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
        rawImage{i} = imread(imageFile);
    end
    save(strcat('ImageMat',filesep,folder),'rawImage','nameList');
    fprintf('Images Saved as %s.mat \n',folder);
else
    fprintf('Error! Image Directory does not Exist! \n');
end