function embryos = createEmbryoFromYOLO(csvFile, workspace)

% extract data from yolo to be readable in matlab
data = readtable(csvFile);

minConfidence = 0.8;
data = data(data.confidence >= minConfidence, :);

if isempty(data)
    warning("No embryos detected")
    embryos = struct([]);
    return
end

imageWidth = data.image_width(1);
imageHeight = data.image_height(1);


% recreate # of embryos inside matlab workspace
numEmbryos = height(data);
embryos = struct([]);

for i = 1:numEmbryos
    embryo = struct();

    embryo.state = "free";
    embryo.attempts = 0;
    embryo.pickedSuccessfully = false;

    embryo.shape = 'ellipsoid';
    embryo.width = 0.2;
    embryo.length = 0.5;
    embryo.height = 0.2;

    embryo.confidence = data.confidence(i);

    % YOLO data pixel position
    xPixel = data.x(i);
    yPixel = data.y(i);

    % for now use exact pixel position


    embryo.position = pixelToWorkspace(xPixel,yPixel,imageWidth,imageHeight,workspace);

    % angle of theta from YOLO
    yaw = -data.theta(i);

    Rz = [cos(yaw) -sin(yaw) 0; sin(yaw) cos(yaw) 0; 0 0 1];
    embryo.orientation = Rz;
    embryo.pose = [embryo.orientation embryo.position; 0 0 0 1]; 

    if i == 1
        embryos = embryo;
    else
        embryos(i) = embryo;
    end
end

end

  

