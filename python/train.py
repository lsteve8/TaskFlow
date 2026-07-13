from ultralytics import YOLO

def main():
# load pretrained yolov8 model
    model = YOLO("runs/obb/runs/embryo_obb_v3-2/weights/best.pt")

# train the model
    results = model.train(
            data="datasets/embryofixv3-4aa26abc/data.yaml",
            epochs = 100,
            imgsz = 640,
            device = 0,
            batch = 8,
            workers = 0,
            project = "runs",
            name = "embryo_obb_v3-2",
            plots = True,
            show_labels = False,
            show_conf = False,
         )
if __name__ == "__main__":
        main()