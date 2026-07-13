function updateSimulation (workspace,embryos,tool,showIDs,showArrows)

clf

plotEmbryos3D(workspace,embryos,showIDs,showArrows)

hold on

plotToolHead3D(tool)

drawnow

end