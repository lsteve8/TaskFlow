function embryos = detectEmbryos(imagePath, workspace)

csvFile = "C:\Users\lukes\dev_ws\obb_predictions_v3.csv";

runYOLO(imagePath)

embryos = createEmbryoFromYOLO(csvFile,workspace);

end
