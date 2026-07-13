function movedPosition = getMovedPosition(embryos, workspace)

movedCount = 0;

for i = 1:length(embryos)
    if embryos(i).state == "moved" 
        movedCount = movedCount + 1;
    end
end


xStart = workspace.movedregion(1);
yStart = workspace.movedregion(2);
regionWidth = workspace.movedregion(3);

% grid settings
spacing = embryos(1).length * 4;
numCols = floor(regionWidth / spacing);

col = mod(movedCount, numCols);
row = floor(movedCount / numCols);

x = xStart + spacing/2 + col*spacing;
y = yStart + spacing/2 + row*spacing;
z = embryos(1).height/2;

movedPosition = [x;y;z];

end