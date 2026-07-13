function embryos = selectNearEmbryo(embryos,targetPoint)
% function for automating embryo selection

%initialize distance and targetID

bestDistance = inf;
targetID = 0;
for i = 1:length(embryos)
 if embryos(i).state == "free"
     distance = norm(embryos(i).position - targetPoint);
    if distance < bestDistance
        bestDistance = distance;
        targetID = i;
    end
 end
end

% using found target ID select embryo
if targetID == 0
    warning('No embryos left to select')
    return
end
embryos = selectEmbryos(embryos,targetID);
end 