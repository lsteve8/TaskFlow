function simulationSummary(embryos)

states = string({embryos.state});

numTotal = length(embryos);
numMoved = sum(states == "moved");
numGrasped = sum(states == "grasped");
numSelected = sum(states == "selected");
numFailed = sum(states == "failed");
numFree = sum(states == "free");

totalAttempts = sum([embryos.attempts]);
successfulPickups = sum([embryos.pickedSuccessfully]);

if numTotal > 0
    averageAttempts = totalAttempts/numTotal;
else
    averageAttempts = 0;
end

if numMoved > 0 
    successRate = 100 * numMoved /(numMoved + numFailed);
else 
    successRate = 0;
end

fprintf('\n----- Simulation Summary -----\n');
fprintf('Total embryos:        %d\n', numTotal);
fprintf('Successfully moved:   %d\n', numMoved);
fprintf('Failed embryos:       %d\n', numFailed);
fprintf('Free remaining:       %d\n', numFree);
fprintf('Still selected:       %d\n', numSelected);
fprintf('Still grasped:        %d\n', numGrasped);
fprintf('Total grasp attempts: %d\n', totalAttempts);
fprintf('Successful pickups:   %d\n', successfulPickups);
fprintf('Average attempts:     %.2f\n', averageAttempts);
fprintf('Success rate:         %.1f%%\n', successRate);
fprintf('------------------------------\n');

end
