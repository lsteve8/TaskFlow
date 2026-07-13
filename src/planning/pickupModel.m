function pickupProbability = pickupModel(embryo, tool)

baseProbability = 0.7;

% Increase contact area increase % pickup
contactFactor = embryo.width/0.2;

% repeat attempts lowers chances
attemptPenalty = 0.05*embryo.attempts;

pickupProbability = baseProbability * contactFactor - attemptPenalty;

pickupProbability = max(0,min(1, pickupProbability));

end