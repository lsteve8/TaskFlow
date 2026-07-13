function [embryos, tool] = releaseEmbryo(embryos, tool, movedPosition)

attachedID = tool.attachedEmbryoID;

if attachedID == 0 
    warning('No embryo attached')
    return
end

% final orientation
yaw = pi/2;

Rz = [cos(yaw) -sin(yaw) 0; sin(yaw) cos(yaw) 0; 0 0 1];

% finalize position of embryo
embryos(attachedID).orientation = Rz;
embryos(attachedID).position = movedPosition;
embryos(attachedID).pose = [embryos(attachedID).orientation embryos(attachedID).position; 0 0 0 1];

embryos(attachedID).state = "moved";

% release tool
tool.hasEmbryo = false;
tool.attachedEmbryoID = 0;
tool.state = "released";

end