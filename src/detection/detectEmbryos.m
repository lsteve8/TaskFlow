function embryos = detectEmbryos(imagePath, workspace)

csvFile = "C:\Users\lukes\dev_ws\obb_predictions_v3.csv";

if isfile(csvFile)
    delete(csvFile);
end

runYOLO(imagePath);

if ~isfile(csvFile)
    error("YOLO did not create the expected prediction CSV.")
end

embryos = createEmbryoFromYOLO(csvFile, workspace);

end