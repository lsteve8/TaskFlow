function tool = returnHome(tool)

tool.targetPosition = tool.homePosition;
tool.position = tool.homePosition;

tool.pose = [tool.orientation tool.position; 0 0 0 1];
tool.state = "home";

end