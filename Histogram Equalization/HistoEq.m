function eq = HistoEq(h,I)

    ncolumns = size(I, 2);
    nrows = size(I, 1);
    pdf = h/(ncolumns*nrows);
    S = zeros(256,1); 
    eq_Im = zeros(nrows,ncolumns);
    for i = 1:256
        S(i) = round(sum(pdf(1:i)*255));
    end
    for c = 1:ncolumns
        for r = 1:nrows
            eq_Im(r, c) = S(int16(I(r, c))+1);
        end
    end
    eq = eq_Im;
end
