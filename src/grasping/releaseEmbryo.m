function [embryos, tool] = releaseEmbryo( ...
    embryos, tool, hardware, movedPosition)

attachedID = tool.attachedEmbryoID;

if attachedID == 0
    warning("No embryo attached");
    return
end

% Release using pump only in hardware mode
if ~hardware.isSimulation
    releaseWithPump(hardware.pump, 2.7);
end

% Final embryo orientation
yaw = pi/2;

Rz = [ ...
    cos(yaw) -sin(yaw) 0;
    sin(yaw)  cos(yaw) 0;
    0         0        1];

% Update embryo

embryos(attachedID).orientation = Rz;
embryos(attachedID).position = movedPosition;
embryos(attachedID).pose = [ ...
    embryos(attachedID).orientation ...
    embryos(attachedID).position;
    0 0 0 1];

embryos(attachedID).state = "moved";

% Release tool

tool.hasEmbryo = false;
tool.attachedEmbryoID = 0;
tool.state = "released";

end