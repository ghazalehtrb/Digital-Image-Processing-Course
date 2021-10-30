% partition entropy evaluation metric
function [vpe] = Vpe(u)
    N = size(u,1);
    vpe = -sum(sum(u.*log(u),2))/N;
end