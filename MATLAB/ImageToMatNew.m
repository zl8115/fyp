close all, clear all

% Converts obtained .png files to .mat cells

% Folder and Image Variables
folder = 'Trial1';

% Static Settings
imageFolder = 'ImageSet';
imageExtension = '.png';

% Defines the imageDirectory and nameList
imageDirectory = strcat('./',imageFolder,'/',folder,'/');
nameList = [lowerRange:stepSize:upperRange];
clear imageFolder;

if isfolder(imageDirectory)
    dinfo = dir(strcat(imageDirectory,'*',imageExtension));
    isAvr = ~cellfun(@isempty, regexp({dinfo.name},'_avr'));
    if length(isAvr) == length(~isAvr)
        nameList_avr = {dinfo(isAvr).name};
        nameList = {dinfo(~isAvr).name};
        for i = 1:length(isAvr)
            imageFile = strcat(imageDirectory,);
        end
    end
%% Edited until here
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