clear
clc
close all

projectFolder = fileparts( ...
    matlab.desktop.editor.getActiveFilename);

addpath(genpath(fullfile(projectFolder,"src")));

% Mode
mode = "simulation";
% mode = "actual";

% create workspace for simulation
workspace = createWorkspace();

% initialize pump and hardware
hardware = struct();

switch mode

    case "simulation"

        hardware.isSimulation = true;
        hardware.pump = [];

    case "actual"

        hardware.isSimulation = false;

        pump = serialport("COM3",115200);

        configureTerminator(pump,"CR");
        pump.Timeout = 3;
        flush(pump);

        % Pump configuration
        writeline(pump,"diameter 15.9 mm");
        writeline(pump,"irate 20 ml/min");
        writeline(pump,"wrate 20 ml/min");

        hardware.pump = pump;

    otherwise

        error("Unknown mode.")

end

% create path to python code and extract position
imagePath = ...
    "C:\Users\lukes\dev_yolo\datasets\test7_3\40xtest3.jpg";

numSteps = 50;
showIDs = false;
showArrows = false;
targetPoint = [50; 50; 0.1];

embryos = detectEmbryos(imagePath, workspace);
embryos = detectClusteredEmbryos(embryos);

toolhead = createToolHead(workspace);

motionLog = initializeMotionLog();
motionLog = recordToolMotion(motionLog, toolhead);

figure

plotEmbryos3D( ...
    workspace, embryos, showIDs, showArrows)

hold on
plotToolHead3D(toolhead)

title("Initial workspace")

% run simulation

while hasFreeEmbryos(embryos)

    embryos = selectNearEmbryo(embryos, targetPoint);

    [embryos, toolhead, motionLog] = ...
        moveToolToEmbryo( ...
            embryos, ...
            toolhead, ...
            numSteps, ...
            workspace, ...
            showIDs, ...
            showArrows, ...
            motionLog);

    clf

    plotEmbryos3D( ...
        workspace, embryos, showIDs, showArrows)

    hold on
    plotToolHead3D(toolhead)

    title("Tool above selected embryo")

    drawnow
    pause(0.2)

    [embryos, toolhead] = ...
        graspEmbryo(embryos, toolhead, hardware);

    motionLog = recordToolMotion( ...
        motionLog, toolhead);

    if ~toolhead.hasEmbryo

        [embryos, toolhead, motionLog] = ...
            raiseTool( ...
                embryos, ...
                toolhead, ...
                numSteps, ...
                workspace, ...
                showIDs, ...
                showArrows, ...
                motionLog);

        continue
    end

    clf

    plotEmbryos3D( ...
        workspace, embryos, showIDs, showArrows)

    hold on
    plotToolHead3D(toolhead)

    
    title("Embryo grasped")

    drawnow
    pause(0.2)


    movedPosition = ...
        getMovedPosition(embryos, workspace);

    [embryos, toolhead, motionLog] = ...
        moveToolFinal( ...
            embryos, ...
            toolhead, ...
            numSteps,...
            movedPosition, ...
            workspace, ...
            showIDs, ...
            showArrows, ...
            motionLog);

    clf

    plotEmbryos3D( ...
        workspace, embryos, showIDs, showArrows)

    hold on
    plotToolHead3D(toolhead)

    title("Tool above moved position")

    drawnow
    pause(0.2)

    [embryos, toolhead] = ...
        releaseEmbryo( ...
            embryos, toolhead, hardware, movedPosition);

    motionLog = recordToolMotion( ...
        motionLog, toolhead);

    clf

    plotEmbryos3D( ...
        workspace, embryos, showIDs, showArrows)

    hold on
    plotToolHead3D(toolhead)

    title("Embryo released")

    drawnow
    pause(0.2)

end

[embryos, toolhead, motionLog] = ...
    returnHome( ...
        embryos, ...
        toolhead, ...
        numSteps, ...
        workspace, ...
        showIDs, ...
        showArrows, ...
        motionLog);

% create simulation summary

simulationSummary(embryos, motionLog);