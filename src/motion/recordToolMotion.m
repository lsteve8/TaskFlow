function motionLog = recordToolMotion(motionLog, tool)

% Record XYZ translation
position = tool.pose(1:3, 4)';

% Record rotation matrix
R = tool.pose(1:3, 1:3);

% Extract roll, pitch, yaw using ZYX convention
pitch = atan2(-R(3,1), sqrt(R(1,1)^2 + R(2,1)^2));

if abs(cos(pitch)) > 1e-8
    roll = atan2(R(3,2), R(3,3));
    yaw = atan2(R(2,1), R(1,1));
else
    roll = 0;
    yaw = atan2(-R(1,2), R(2,2));
end

motionLog.positions(end+1, :) = position;
motionLog.rotation(end+1, :) = [roll, pitch, yaw];

if isfield(tool, "state")
    motionLog.toolState(end+1, 1) = string(tool.state);
else
    motionLog.toolState(end+1, 1) = "unknown";
end

end