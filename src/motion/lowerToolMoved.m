function [embryos, tool, motionLog] = lowerToolMoved(embryos,tool,movedPosition,numSteps,workspace,showIDs,showArrows,motionLog)

targetPosition = movedPosition + [0; 0; tool.height];

[embryos, tool] = moveTool(embryos,tool,targetPosition,numSteps,workspace,showIDs,showArrows,motionLog);

tool.state = "placeContact";

end