function h = Histo(I)

    ncolumns = size(I, 2);
    nrows = size(I, 1);
    count = zeros(256,1); 
    for c = 1:ncolumns
        for r = 1:nrows
            count(int16(I(r, c))+1) = count(int16(I(r, c))+1) + 1;
        end
    end
    h = count
end


