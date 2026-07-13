function runYOLO(imagePath)

pythonExe = "C:\Users\lukes\dev_yolo\yolovenv\Scripts\python.exe";
pythonScript = "C:\Users\lukes\dev_yolo\extract_obb_data.py";

command = """" + pythonExe + """ """ + pythonScript + """ """ + imagePath + """";

status = system(command);

if status ~= 0 
    error("Python script failed to run")
end

end