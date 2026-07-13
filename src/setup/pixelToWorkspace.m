function position = pixelToWorkspace(xPixel, yPixel, imageWidth, imageHeight, workspace)

sourceX = workspace.sourceregion(1);
sourceY = workspace.sourceregion(2);
sourceW = workspace.sourceregion(3);
sourceH = workspace.sourceregion(4);

x = sourceX+(xPixel/imageWidth)*sourceW;
y = sourceY+((imageHeight - yPixel)/imageHeight)*sourceH;
z = 0.1;

position = [x;y;z];

end
