function plotEmbryos(workspace,embryos)

% draw 2D plot for work function
figure;
hold on;   

% workspace size
width = workspace.size(1);
depth = workspace.size(2);

% draw boundary
rectangle('Position', workspace.sourceregion,'Edgecolor','w', 'Linewidth',2)

% plot each embryo 
for i = 1:length(embryos)
    % create varying orientation for embryos
   theta = linspace(0, 2*pi, 50);

    xCenter = embryos(i).position(1);
   yCenter = embryos(i).position(2);

   a = embryos(i).length/2;
   b = embryos(i).width/2;

   xEllipse = a*cos(theta);
   yEllipse = b*sin(theta);

   ellipsePoints = [xEllipse; yEllipse; zeros(size(theta))];

   R = embryos(i).orientation;
    % add arrows to see intended orientation in the process
   direction = R(:,1);
   
   arrowlength = embryos(i).length;

   quiver(xCenter, yCenter, arrowlength*direction(1),arrowlength*direction(2),0,'Linewidth',1.5,'MaxHeadSize',2)

   rotatedPoints = R* ellipsePoints;
% plot the embryos with varying orientation as ellipses onto the workspace
   

   xPlot = rotatedPoints(1,:) + xCenter;
   yPlot = rotatedPoints(2,:) + yCenter;
  

   plot(xPlot, yPlot,'cyan','Linewidth',1)
    text(xCenter+0.2, yCenter+0.2,num2str(i),'Fontsize',8,'FontWeight','bold')
end

axis equal;
xlim([0 width]);
ylim([0 depth]);

xlabel('X axis');
ylabel('Y axis');
title('2D Visualization');

grid on;
end