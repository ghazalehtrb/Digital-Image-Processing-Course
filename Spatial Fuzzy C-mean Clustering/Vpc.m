% partition coefficient evaluation metric
function [vpc] = Vpc(u)
    N = size(u,1);
    vpc = sum(sum(u.^2))/N;
end