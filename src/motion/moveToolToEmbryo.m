function [embryos, tool] = moveToolToEmbryo(embryos, tool, numSteps, workspace, showIDs, showArrows)

% find embryo
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

% move tool above selected embryo
targetPosition  = embryos(selectedID).position + [0; 0; tool.clearance];

[embryos, tool] = moveTool(embryos,tool,targetPosition,numSteps,workspace,showIDs,showArrows);

tool.state = "aboveEmbryo";

end
