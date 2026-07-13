function saveImage(imageName)

% folder to store images
folder = "SimulationScreenshots";

% create folder if it doesn't exist
if ~exist(folder,'dir')
    mkdir(folder)
end

drawnow;

% filename
filename = fullfile(folder, imageName + ".png");

% Save figure
exportgraphics(gcf, filename, "resolution", 300)
fprintf("Saved: %s\n",filename)

end