function [embryos, tool] = graspEmbryo(embryos, tool)

% intialize ID for embryo
selectedID = 0;

% assign ID for selected embryo
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

% initialize grasp mechanism for selected embryo
embryos(selectedID).attempts = embryos(selectedID).attempts + 1;

pickupProbability = pickupModel(embryos(selectedID),tool);
pickupSuccess =  rand < pickupProbability;

if pickupSuccess
    tool.hasEmbryo = true;
    tool.attachedEmbryoID = selectedID;
    tool.state = "grasped";
    embryos(selectedID).state = "grasped";
    embryos(selectedID).pickedSuccessfully = true;
else
    tool.hasEmbryo = false;
    tool.attachedEmbryoID = 0;
    tool.state = "failedGrasp";

    if embryos(selectedID).attempts >= 3
        embryos(selectedID).state = "failed";
    else
        embryos(selectedID).state = "free";
    end

end

end