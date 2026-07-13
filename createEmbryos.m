% function for creating embryo properties 
function embryos = createEmbryos(numEmbryos, workspace)

embryos = struct([]);

minSpacing = 0.5;
maxAttempts = 100;



% generate desired # of embryos
for i = 1:numEmbryos

    % define the embryo shape and size (mm)
    embryo = struct();

    embryo.state = "free";
    embryo.attempts = 0;
    embryo.pickedSuccessfully = false;

    embryo.shape = 'ellipsoid';
    embryo.width = 0.2;
    embryo.length = 0.5;
    embryo.height = 0.2;
    
    % give random position to each embryo inside the workspace

 placed = false;
 attempts = 0;
 while placed == false && attempts < maxAttempts
     attempts = attempts + 1;
% create embryo with random position within the given workspace
xStart = workspace.sourceregion(1);
yStart = workspace.sourceregion(2);

fWidth = workspace.sourceregion(3);
fHeight = workspace.sourceregion(4);

margin = embryo.length;

     x = xStart + margin + (fWidth - 2*margin)*rand();
     y = yStart + margin + (fHeight - 2*margin)*rand();
     z = embryo.height/2;
     newPosition = [x; y; z];
     
     % prevent overlap in the embryo generation
     overlap = false;
     
     for j = 1:i-1
         oldPosition = embryos(j).position;

         distance = norm(newPosition(1:2) - oldPosition(1:2));

         if distance < minSpacing
             overlap = true;
             break
         end
     end
     
     if overlap == false
         embryo.position = newPosition;
         placed = true;
     end
        
 end

 if placed == false 
     error('Could not place embryo without overlap. Try larger workspace or fewer embryo')
 end

    % assign orientation to the embryos
  
    yaw = 2*pi*rand();
    Rz = [cos(yaw) -sin(yaw) 0; sin(yaw) cos(yaw) 0; 0 0 1];
    embryo.orientation = Rz;
    embryo.pose = [ Rz embryo.position; 0 0 0 1];
    % physical & mechanical properties of the embryo
    % embryo.mass = 1e-7;
    % embryo.youngsModulus = 1e5;
    % embryo.poissonRatio = 0.22;
    % 
    % embryo.surfaceEnergy = 0.05;
    % embryo.frictionCoefficient = 0.4;
    if i == 1
        embryos = embryo; 
    else 
        embryos(i) = embryo;
    end
end
end




