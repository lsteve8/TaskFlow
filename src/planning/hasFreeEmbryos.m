function hasFree = hasFreeEmbryos(embryos)

hasFree = false;

for i = 1:length(embryos)
    if embryos(i).state == "free"
        hasFree = true;
        return
    end
end

end