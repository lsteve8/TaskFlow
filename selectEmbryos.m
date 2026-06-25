function embryos = selectEmbryos(embryos, targetID)

% create a loop to select desired embyros
for i = 1:length(embryos)
    if embryos(i).state == "selected"
        embryos(i).state = "free";
    end
end

embryos(targetID).state = "selected";

end