clear
clc
close all

projectFolder = fileparts( ...
    matlab.desktop.editor.getActiveFilename);

addpath(genpath(fullfile(projectFolder, "src")));

workspace = createWorkspace();

imagePath = ...
    "C:\Users\lukes\dev_yolo\datasets\test7_3\80xtest2.jpg";

numSteps = 25;
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
        graspEmbryo(embryos, toolhead);

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
            embryos, toolhead, movedPosition);

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

simulationSummary(embryos, motionLog);