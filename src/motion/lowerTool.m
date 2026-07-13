function [embryos, tool] = lowerTool(embryos, tool, numSteps, workspace, showIDs, showArrows)

attachedID = 0;

for i = 1:length(embryos)
    if embryos(i).state == "selected"
        attachedID = i;
        break
    end
end

if attachedID == 0
    warning('No embryo found')
end

targetPosition = embryos(attachedID).position + [0; 0; embryos(attaachedID).height + tool.height];

[embryos,tool] = moveTool(embryos,tool,targetPosition,numSteps,workspace,showIDs,showArrows);

tool.state = "contact";

end