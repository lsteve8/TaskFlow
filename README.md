# TaskFlow

TaskFlow is a MATLAB-based robotic grasp guidance and simulation framework for automated **Drosophila embryo manipulation**. The project integrates computer vision, coordinate transformation, and robotic motion planning to simulate autonomous embryo pick-and-place operations.

## Overview

The TaskFlow pipeline performs the following steps:

1. Detect embryos from microscope images using a YOLOv8 Oriented Bounding Box (OBB) model.
2. Convert image detections into workspace coordinates.
3. Identify clustered embryos and select a target embryo.
4. Plan and execute a simulated pick-and-place sequence.
5. Update the simulation and repeat until all embryos have been relocated.

## Features

* YOLOv8 OBB embryo detection
* Pixel-to-workspace coordinate transformation
* Clustered embryo detection
* Automated embryo selection
* Robotic pick-and-place simulation
* 3D visualization of embryos and toolhead
* Simulation statistics and reporting

## Project Structure

```text
TaskFlow/
│
├── runSimulation.m        # Main simulation entry point
├── src/
│   ├── setup/
│   ├── detection/
│   ├── planning/
│   ├── motion/
│   ├── grasping/
│   ├── visualization/
│   └── reporting/
│
├── docs/
└── tests/
```

## Requirements

* MATLAB
* Python (for YOLO inference)
* Ultralytics YOLOv8
* Computer Vision Toolbox (if required by your installation)

## Running the Simulation

Open MATLAB and execute:

```matlab
runSimulation
```

The simulation will:

* Initialize the workspace
* Detect embryos
* Convert detections into workspace coordinates
* Execute the grasp guidance algorithm
* Simulate embryo relocation
* Display the updated workspace

## Current Status

The current implementation includes:

* Computer vision integration
* Robotic grasp guidance
* Pick-and-place simulation
* Workspace visualization

Future work includes improving grasp planning, handling complex embryo clusters, and integrating physical robotic hardware.

## Author

Luke Stevens

Mechanical Engineering, Clemson University

Summer Undergraduate Research Program

The University of Tokyo
