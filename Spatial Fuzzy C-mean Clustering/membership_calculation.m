% calculation of final membeship values with respect to the average cluster
% centers to reduce the sensitivity to random initialization
function [u] = membership_calculation(x,centroid,k,m,w,p,q,ncolumns,nrows)
        eps = 0.000001;
        number_samples = size(x, 1);
        distance_array = [];
        for j = 1:k
            d = vecnorm([(x-centroid(j,:))'])' + eps;
            distance_array = [distance_array, d];
        end
        size(d);
        u_temp = ones(number_samples,k)./(((distance_array).^(2/(m-1))).*(sum((ones(number_samples,k)./distance_array).^(2/(m-1)),2)));

        reshaped_u_temp = reshape(u_temp,[ncolumns,nrows,k]);
%         padded = padarray(reshaped_u_temp,[(w-1)/2 (w-1)/2],0,'both');
        filter = ones(w,w);
        
        for j = 1:k
           h(:,j) = reshape(conv2(reshaped_u_temp(:,:,j),filter,'same'),ncolumns*nrows,1);
        end
        
        T = sum((u_temp.^p).*(h.^q),2);

        for j = 1:k
           u(:,j) = ((u_temp(:,j).^p).*(h(:,j).^q))./(T);
        end
end