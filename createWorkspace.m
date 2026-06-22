% function for creating workspace for the embryos
function ws = createWorkspace()

% define the workspace size as well as material properties
ws.size = [ 100, 100, 20];
ws.material = 'glass';
ws.surface = 0;


% define the material mechanical properteis

ws.coefffriction = 0.4; 
ws.youngsmodulus = 70e5; % Pa
ws.poissonratio = 0.22;
ws.density = 2500; % kg/m^3
ws.surfaceenergy = 0.1; % J/m^2
end