function [embryos, tool] = lowerToolMoved(embryos,tool,movedPosition,numSteps,workspace,showIDs,showArrows)

targetPosition = movedPosition + [0; 0; tool.height];

[embryos, tool] = moveTool(embryos,tool,targetPosition,numSteps,workspace,showIDs,showArrows);

tool.state = "placeContact";

end