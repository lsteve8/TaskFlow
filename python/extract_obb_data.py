from matplotlib import image
from ultralytics import YOLO
import pandas as pd
import sys 
from pathlib import Path
from PIL import Image

def predict_single_image(image_path, output_csv="obb_predictions_v3.csv"):
    model = YOLO(r"C:\Users\lukes\dev_yolo\runs/obb/runs/embryo_obb_v3-3/weights/best.pt")

    image = Image.open(image_path)
    image_width, image_height = image.size
    print(f"Image size: {image_width}x{image_height}")

    results = model.predict(
        source=image_path,  
        imgsz=640,
        conf=0.8,
        device=0,
        save=True,
        show_labels=False,
        show_conf=False,
    )

    rows = []
    for result in results:
        image_name = Path(result.path).name

        if result.obb is None or len(result.obb) == 0:
            continue

        # xyz and angle
        obb_data = result.obb.xywhr.cpu().numpy()
        classes = result.obb.cls.cpu().numpy()
        confidences = result.obb.conf.cpu().numpy()

        for box, cls, conf in zip(obb_data, classes, confidences):
            x_center, y_center, width, height, angle = box

            rows.append({
                "image": image_name,
                "image_width": image_width,
                "image_height": image_height,
                "class_id": int(cls),
                 "confidence": float(conf),
                "x": float(x_center),
                "y": float(y_center),
                "width": float(width),
                "height": float(height),
                "theta": float(angle),
            })

    df = pd.DataFrame(rows)
    df.to_csv(output_csv, index=False)

    print(f"Saved {len(df)} detections from {image_path} to {output_csv}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        raise ValueError("Please provide the path to the image as a command line argument.")
    
    image_path = sys.argv[1]
    
    predict_single_image(
        image_path=r"C:\Users\lukes\dev_yolo\datasets/test7_3/40xtest4.jpg",
        output_csv="C:\\Users\\lukes\\dev_ws\\obb_predictions_v3.csv"
    )
