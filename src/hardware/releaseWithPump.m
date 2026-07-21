function releaseWithPump(pump, releaseVolume)

rate = 20; % mL/min

% Time needed for MATLAB to wait while pump completes movement
moveTime = (releaseVolume / rate) * 60;

flush(pump);

% Inflate PDMS actuator
writeline(pump, "stop");
writeline(pump, "cvolume");

writeline(pump, sprintf("irate %.3f ml/min", rate));
writeline(pump, sprintf("tvolume %.3f ml", releaseVolume));

writeline(pump, "irun");

% Pump stops itself at target volume
pause(moveTime + 1);

% Retract syringe
writeline(pump, "stop");
writeline(pump, "cvolume");

writeline(pump, sprintf("wrate %.3f ml/min", rate));
writeline(pump, sprintf("tvolume %.3f ml", releaseVolume));

writeline(pump, "wrun");

% Pump stops itself at target volume
pause(moveTime + 2);

end