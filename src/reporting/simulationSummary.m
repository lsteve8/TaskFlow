function simulationSummary(embryos, motionLog)

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
    averageAttempts = totalAttempts / numTotal;
else
    averageAttempts = 0;
end

if (numMoved + numFailed) > 0
    successRate = 100 * numMoved / (numMoved + numFailed);
else
    successRate = 0;
end

numMotionSamples = size(motionLog.positions, 1);

if numMotionSamples >= 2

    positionDifferences = diff(motionLog.positions, 1, 1);
    segmentDistances = vecnorm(positionDifferences, 2, 2);

    movingSegments = segmentDistances(segmentDistances > 1e-9);

    totalToolDistance = sum(segmentDistances);

    if ~isempty(movingSegments)
        minimumSegmentDistance = min(movingSegments);
        maximumSegmentDistance = max(movingSegments);
        averageSegmentDistance = mean(movingSegments);
    else
        minimumSegmentDistance = 0;
        maximumSegmentDistance = 0;
        averageSegmentDistance = 0;
    end

else
    totalToolDistance = 0;
    minimumSegmentDistance = 0;
    maximumSegmentDistance = 0;
    averageSegmentDistance = 0;
end

if numMotionSamples > 0

    startPosition = motionLog.positions(1, :);
    finalPosition = motionLog.positions(end, :);

    minimumPosition = min(motionLog.positions, [], 1);
    maximumPosition = max(motionLog.positions, [], 1);

    positionRange = maximumPosition - minimumPosition;

else
    startPosition = [0, 0, 0];
    finalPosition = [0, 0, 0];
    minimumPosition = [0, 0, 0];
    maximumPosition = [0, 0, 0];
    positionRange = [0, 0, 0];
end

numRotationSamples = size(motionLog.rotation, 1);

if numRotationSamples >= 2

    unwrappedRotation = unwrap(motionLog.rotation, [], 1);

    rotationDifferences = diff(unwrappedRotation, 1, 1);

   movingYawChanges = ...
    motionLog.moveYawChanges(motionLog.moveYawChanges > 1e-9);


if ~isempty(movingYawChanges)
    maximumYawAdjustment = max(movingYawChanges);
    averageYawAdjustment = mean(movingYawChanges);
else
    maximumYawAdjustment = 0;
    averageYawAdjustment = 0;
end

    cumulativeRotation = sum(abs(rotationDifferences), 1);

    netRotation = ...
        unwrappedRotation(end, :) - unwrappedRotation(1, :);

    minimumRotation = min(unwrappedRotation, [], 1);
    maximumRotation = max(unwrappedRotation, [], 1);
    rotationRange = maximumRotation - minimumRotation;

    angularStepMagnitude = ...
        vecnorm(rotationDifferences, 2, 2);

    totalAngularMotion = sum(angularStepMagnitude);

elseif numRotationSamples == 1

    maximumYawAdjustment = 0;
    averageYawAdjustment = 0;

    cumulativeRotation = [0, 0, 0];
    netRotation = [0, 0, 0];

    minimumRotation = motionLog.rotation(1, :);
    maximumRotation = motionLog.rotation(1, :);

    rotationRange = [0, 0, 0];
    totalAngularMotion = 0;

else

    maximumYawAdjustment = 0;
    averageYawAdjustment = 0;
    cumulativeRotation = [0, 0, 0];
    netRotation = [0, 0, 0];
    minimumRotation = [0, 0, 0];
    maximumRotation = [0, 0, 0];
    rotationRange = [0, 0, 0];
    totalAngularMotion = 0;

end

cumulativeRotationDeg = rad2deg(cumulativeRotation);
netRotationDeg = rad2deg(netRotation);
minimumRotationDeg = rad2deg(minimumRotation);
maximumRotationDeg = rad2deg(maximumRotation);
rotationRangeDeg = rad2deg(rotationRange);
totalAngularMotionDeg = rad2deg(totalAngularMotion);

maximumYawAdjustmentDeg = rad2deg(maximumYawAdjustment);
averageYawAdjustmentDeg = rad2deg(averageYawAdjustment);

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

fprintf('\n----- Tool Motion Summary -----\n');
fprintf('Recorded motion samples: %d\n', numMotionSamples);

fprintf('\nPosition information:\n');
fprintf('Start position:          [%.3f, %.3f, %.3f] mm\n', ...
    startPosition);
fprintf('Final position:          [%.3f, %.3f, %.3f] mm\n', ...
    finalPosition);
fprintf('Minimum position:        [%.3f, %.3f, %.3f] mm\n', ...
    minimumPosition);
fprintf('Maximum position:        [%.3f, %.3f, %.3f] mm\n', ...
    maximumPosition);
fprintf('XYZ position range:      [%.3f, %.3f, %.3f] mm\n', ...
    positionRange);

fprintf('\nDistance information:\n');
fprintf('Total tool distance:     %.3f mm\n', totalToolDistance);
fprintf('Minimum movement step:   %.3f mm\n', minimumSegmentDistance);
fprintf('Maximum movement step:   %.3f mm\n', maximumSegmentDistance);
fprintf('Average movement step:   %.3f mm\n', averageSegmentDistance);

fprintf('\nRotation information (roll, pitch, yaw):\n');
fprintf('Minimum orientation:     [%.2f, %.2f, %.2f] deg\n', ...
    minimumRotationDeg);
fprintf('Maximum orientation:     [%.2f, %.2f, %.2f] deg\n', ...
    maximumRotationDeg);
fprintf('Maximum yaw adjustment:  %.2f deg\n', ...
    maximumYawAdjustmentDeg);

fprintf('Average yaw adjustment:  %.2f deg\n', ...
    averageYawAdjustmentDeg);
fprintf('Orientation range:       [%.2f, %.2f, %.2f] deg\n', ...
    rotationRangeDeg);
fprintf('Net rotation:            [%.2f, %.2f, %.2f] deg\n', ...
    netRotationDeg);
fprintf('Cumulative rotation:     [%.2f, %.2f, %.2f] deg\n', ...
    cumulativeRotationDeg);
fprintf('Total angular motion:    %.2f deg\n', ...
    totalAngularMotionDeg);

fprintf('--------------------------------\n');

end