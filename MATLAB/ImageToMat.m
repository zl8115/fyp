close all, clear all

% Folder and Image Variables
folder = 'Trial1';
lowerRange = -290;
upperRange = 290;
stepSize = 5;

% Static Settings
imageFolder = 'ImageSet';
imageExtension = '.png';

% 
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
    save(folder,'rawImage','avrImage','nameList');
    fprintf('Images Saved as %s.mat \n',folder);
else
    fprintf('Error! Image Directory does not Exist! \n');
end