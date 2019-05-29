folder = "Trial1"

if isfolder(folder)
    avr_list = dir(fullfile(folder,'*_avr.png'))
    for i = 1:length(list)
        rawImage{i} = imread(strcat(folder,'/',list(i).name));
    end
end