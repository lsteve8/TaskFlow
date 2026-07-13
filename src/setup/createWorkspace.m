% Function for creating workspace for the embryo simulation
function workspace = createWorkspace()

% dimensions [mm]
workspace.size = [40, 40, 10];

% Source region
workspace.sourceregion = [0, 0, 15, 15];

% Moved region
workspace.movedregion = [35, 5, 25, 25];
workspace.movedSpacing = 4;

% Workspace material
workspace.material = "glass";
workspace.surfaceHeight = 0;

% Material Properties (for future contact mechanics)

workspace.coeffFriction = 0.40;
workspace.youngsModulus = 70e9;      % Pa
workspace.poissonRatio = 0.22;
workspace.density = 2500;            % kg/m^3
workspace.surfaceEnergy = 0.10;      % J/m^2

end