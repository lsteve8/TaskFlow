function [embryos, tool] = raiseTool(embryos,tool,numSteps,workspace,showIDs,showArrows)

targetPosition = tool.position + [0; 0; tool.clearance];

[embryos, tool] = moveTool(embryos,tool,targetPosition,numSteps,workspace,showIDs,showArrows);

tool.state = "lifted";

end