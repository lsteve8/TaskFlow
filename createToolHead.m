function tool = createToolHead(workspace)

tool.name = "adhesionTool";

% define tool specifications and radius of droplet used to contact embryo    
tool.contactRadius = 0.3;
tool.diameter = 1.5;
tool.height = 0.08;
tool.radius = tool.diameter/2;


% define intial tool position as well as give identity matrix for
% calculations
tool.position = [workspace.size(1)/2; workspace.size(2)/2; 10];
tool.orientation = eye(3);

tool.pose = [tool.orientation tool.position; 0 0 0 1];

% define an initial state and shape of the tool head
tool.state = "home";
tool.shape = 'cylinder';



% intialize tool contact and state of tool head
tool.hasEmbryo = false;
tool.attachedEmbryoID = 0;

tool.adhesionModel = "vanDerWaalsDroplet";

tool.homePosition = tool.position;
tool.targetPosition = tool.position;

% tool velocities in mm/s
tool.velocity = 0;
tool.maxVelocity = 10;

tool.path = [];
end