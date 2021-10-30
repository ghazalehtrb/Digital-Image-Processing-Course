% Xie-Beni index evaluation metric
function [vxb] = Vxb(u,x,v)
    N = size(u,1);
    k = size(u,2);
    
    min_distance_clusters = [];
    for j = 1:k
        min_distance_single_cluster = [];
        for i = 1:k
            distance = (vecnorm([v(i,:)-v(j,:)]))^2;
            if distance ~= 0
                min_distance_single_cluster = [min_distance_single_cluster, distance];
            end
        end
        min_distance_clusters = [min_distance_clusters, min(min_distance_single_cluster)];
    end
    distance_array = [];
    for j = 1:k
        d = sum((u(:,j).^2).*((vecnorm([(x-v(j,:))'])').^2));
        distance_array = [distance_array, d];
    end
    vxb = sum(distance_array)/(N*min(min_distance_clusters));
end