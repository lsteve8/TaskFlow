function plotEmbryos3D(workspace,embryos,showIDs,showArrows)

% translate the plotting into a 3D version


hold on;

% workspace size
width = workspace.size(1);
height = workspace.size(2);
depth = workspace.size(3);


% plot each of the embryo in 3D
for i = 1:length(embryos)
    
   [xEll, yEll, zEll] = ellipsoid(0, 0, 0, embryos(i).length/2, embryos(i).width/2, embryos(i).height/2, 10);
   points = [xEll(:)'; yEll(:)'; zEll(:)'];

   R = embryos(i).orientation;
   rotatedPoints = R*points;

  xPlot = reshape(rotatedPoints(1,:), size(xEll)) + embryos(i).position(1);
  yPlot = reshape(rotatedPoints(2,:), size(yEll)) + embryos(i).position(2);
  zPlot = reshape(rotatedPoints(3,:), size(zEll)) + embryos(i).position(3);
if embryos(i).state == "selected"

  surf(xPlot,yPlot,zPlot,'FaceColor','g')
elseif embryos(i).state == "grasped"
    surf(xPlot,yPlot,zPlot,'FaceColor','y')
elseif embryos(i).state == "moved"
    surf(xPlot,yPlot,zPlot,'FaceColor','b')
elseif embryos(i).state == "failed"
    surf(xPlot,yPlot,zPlot,'FaceColor','r')
elseif embryos(i).state == "clustered" 
    surf(xPlot,yPlot,zPlot,'FaceColor','m')
else 
    surf(xPlot, yPlot, zPlot, 'FaceColor', 'w');

end
  if showIDs
  text(embryos(i).position(1)+0.2,embryos(i).position(2)+0.2,embryos(i).position(3)+0.2,num2str(i),'FontSize',8,'FontWeight','bold')
  end
  if showArrows
      direction = R(:,1);
   
   arrowlength = embryos(i).length;

   quiver3(embryos(i).position(1), embryos(i).position(2),embryos(i).position(3), arrowlength*direction(1),arrowlength*direction(2),0,'Linewidth',1.5,'MaxHeadSize',2)
  end
axis equal;
xlim([0 width]);
ylim([0 height]);
zlim([0 depth]);

xlabel('X axis')
ylabel('Y axis')
zlabel('Z axis')
title('3D visualization')

view(3)
grid on;
end
