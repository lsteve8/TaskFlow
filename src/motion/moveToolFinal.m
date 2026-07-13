function [embryos, tool] = moveToolFinal(embryos, tool, movedPosition, workspace, showIDs, showArrows)

% find final position for embryo 
attachedID = tool.attachedEmbryoID; 

if attachedID == 0
    warning('Tool has no attached embryo')
    return
end

% move tool to final position
targetPosition = movedPosition + [0; 0; tool.clearance];

[embryos, tool] = moveTool(embryos,tool,targetPosition,25,workspace,showIDs,showArrows);

tool.state = "aboveMovedPosition";

end