function embryos = detectClusteredEmbryos(embryos)

clusteredThreshold = 0.5;

numEmbryos = length(embryos);

for i = 1:numEmbryos
    embryos(i).isClustered = false;
end

for i = 1:numEmbryos
     for j = i+1:numEmbryos

         pos_i = embryos(i).position(1:2);
         pos_j = embryos(j).position(1:2);

         distance = norm(pos_i - pos_j);

         if distance < clusteredThreshold
             embryos(i).isClustered = true;
             embryos(j).isClustered = true;

             embryos(i).state = 'Clustered';
             embryos(j).state = 'Clustered';
         end
     end
end

end
