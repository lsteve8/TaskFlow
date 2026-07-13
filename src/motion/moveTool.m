function [embryos, tool] = moveTool(embryos, tool, targetPosition, numSteps, workspace, showIDs, showArrows)

startPosition = tool.position;

for k = 1:numSteps
    alpha = k/numSteps;

    tool.position = (1-alpha)*startPosition + alpha*targetPosition;

    tool.pose = [tool.orientation tool.position; 0 0 0 1];

    % if tool has embryo force embryo to follow
    if tool.hasEmbryo
        attachedID = tool.attachedEmbryoID;

        embryos(attachedID).position = tool.position - [0; 0; tool.clearance];
        embryos(attachedID).pose = [embryos(attachedID).orientation embryos(attachedID).position; 0 0 0 1];
    end

    updateSimulation(workspace,embryos,tool,showIDs,showArrows)
    
end

tool.targetPosition = targetPosition;

end

