clear
clc
close all

projectFolder = fileparts(matlab.desktop.editor.getActiveFilename);
addpath(genpath(fullfile(projectFolder, "src")));


workspace = createWorkspace();

imagePath = "C:\Users\lukes\dev_yolo\datasets\test7_3\40xtest3.jpg";

numSteps = 25;
showIDs = false;
showArrows = false;
targetPoint = [50; 50; 0.1];

embryos = detectEmbryos(imagePath,workspace);

embryos = detectClusteredEmbryos(embryos);

toolhead = createToolHead(workspace);

figure
plotEmbryos3D(workspace, embryos, showIDs, showArrows)
    hold on
    plotToolHead3D(toolhead)
    title('Tool above selected embryo')

   

   % saveImage("ctest5")
% while hasFreeEmbryos(embryos)
% 
%     % Select nearest free embryo
%     embryos = selectNearEmbryo(embryos, targetPoint);
% 
%     % Move tool above selected embryo
%     [embryos, toolhead] = moveToolToEmbryo(embryos,toolhead,numSteps,workspace,showIDs,showArrows);
% 
%     clf
%     plotEmbryos3D(workspace, embryos, showIDs, showArrows)
%     hold on
%     plotToolHead3D(toolhead)
%     title('Tool above selected embryo')
%     drawnow
%     pause(0.2)
% 
%     % Grasp embryo
%     [embryos, toolhead] = graspEmbryo(embryos, toolhead);
% 
%     if ~toolhead.hasEmbryo
% 
%        [embryos, toolhead] = raiseTool(embryos,toolhead,numSteps,workspace,showIDs,showArrows);
% 
%        continue
%     end
%     clf
%     plotEmbryos3D(workspace, embryos, showIDs, showArrows)
%     hold on
%     plotToolHead3D(toolhead)
%     title('Embryo grasped')
%     drawnow
%     pause(0.2)
% 
%     % Get next moved position
%     movedPosition = getMovedPosition(embryos, workspace);
% 
%     % Move tool to final position
%     [embryos, toolhead] = moveToolFinal(embryos, toolhead, movedPosition,workspace,showIDs,showArrows);
% 
%     clf
%     plotEmbryos3D(workspace, embryos, showIDs, showArrows)
%     hold on
%     plotToolHead3D(toolhead)
%     title('Tool above moved position')
%     drawnow
%     pause(0.2)
% 
%     % Release embryo
%     [embryos, toolhead] = releaseEmbryo(embryos, toolhead, movedPosition);
% 
%     clf
%     plotEmbryos3D(workspace, embryos, showIDs, showArrows)
%     hold on
%     plotToolHead3D(toolhead)
%     title('Embryo released')
%     drawnow
%     pause(0.2)
% 
% end
% 
% toolhead = returnHome(toolhead);
% 
% simulationSummary(embryos);
% 
