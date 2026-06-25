function embryos =  placeEmbryos(embryos,movedPosition)

selectedID = 0;

for i = 1:length(embryos)
    if embryos(i).state == "selected"
       selectedID = i;
       break
    end
end

if selectedID == 0
    warning('No selected embryo found')
    return
end

yaw = pi/2;

Rz = [cos(yaw) -sin(yaw) 0; sin(yaw) cos(yaw) 0; 0 0 1];

% move selected embryo
embryos(selectedID).position = movedPosition;
embryos(selectedID).orientation = Rz;
embryos(selectedID).pose = [Rz movedPosition; 0 0 0 1];

embryos(selectedID).state = "moved";

end