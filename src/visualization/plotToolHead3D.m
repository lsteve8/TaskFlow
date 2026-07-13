function plotToolHead3D(toolhead)

% create 3D toolhead within matlab simulation
% set parameters for top and bottom of cylinder disk
theta = linspace(0, 2*pi, 40);

r = toolhead.radius;
h = toolhead.height;

x = r*cos(theta) + toolhead.position(1);
y = r*sin(theta) + toolhead.position(2);

zBottom = toolhead.position(3) * ones(size(theta));
zTop = (toolhead.position(3)+h) * ones(size(theta));


% create wall of the tool head side
[xc, yc, zc] = cylinder(toolhead.radius, 30);

xc = xc + toolhead.position(1);
yc = yc + toolhead.position(2);
zc = zc*h + toolhead.position(3);

% create wall
surf(xc, yc, zc, 'FaceColor', 'r', 'EdgeColor', 'k')

% bottom surface 
fill3(x,y,zBottom,'r','EdgeColor','none')

% top surface
fill3(x,y,zTop,'r','EdgeColor','none')
end