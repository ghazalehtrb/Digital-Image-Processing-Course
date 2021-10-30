% sFCM algorithm
function [C, Labels] = Spatial_Cmeans(x,k,max_iter,m,w,p,q,thresh,ncolumns,nrows)
    eps = 0.000001;
    number_samples = size(x, 1);
    idx = randsample(number_samples,k);
    prev_centroid = x(idx,:);
    a = 0;
    u = rand([number_samples k]);
    u = u ./ sum(u,2);
    
    while a < max_iter
        l = [];

        for j = 1:k 
            centroid(j,:) = sum(x.*(u(:,j)).^m)/sum(u(:,j).^m);
        end
        distance_array = [];
        for j = 1:k
            d = vecnorm([(x-centroid(j,:))'])' + eps;
            distance_array = [distance_array, d];
        end
        size(d);
        
        u_temp = ones(number_samples,k)./(((distance_array).^(2/(m-1))).*(sum((ones(number_samples,k)./distance_array).^(2/(m-1)),2)));
        
        reshaped_u_temp = reshape(u_temp,[ncolumns,nrows,k]);
        filter = ones(w,w);
        
        for j = 1:k
           h(:,j) = reshape(conv2(reshaped_u_temp(:,:,j),filter,'same'),ncolumns*nrows,1);
        end
        
        T = sum((u_temp.^p).*(h.^q),2);

        for j = 1:k
           u(:,j) = ((u_temp(:,j).^p).*(h(:,j).^q))./(T);
        end
  
        if abs(centroid - prev_centroid) < thresh
            break
        end   
        prev_centroid = centroid;
        a = a + 1;
    end
    Labels = u;
    C = centroid;

end


