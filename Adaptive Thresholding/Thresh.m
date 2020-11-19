function out = Thres(m,c,I)
    I = double(I)/256;
    ncolumns = size(I, 2);
    nrows = size(I, 1);
    kernel = fspecial('gaussian',m,m/6);
    Th = zeros(nrows,ncolumns); 
    padded = padarray(I,[(m-1)/2 (m-1)/2],'replicate','both');
    for x = 1:ncolumns
        for y = 1:nrows 
            region = padded(y:y+m-1,x:x+m-1);
            WA = sum(kernel.*region,'all');
            Th(y,x) = WA - c ;
        end
    end
    
    figure
    imshow(Th)
    title(['threshold Th =', num2str(c)])
    axis off; 
    
    newIm = zeros(nrows,ncolumns);
    
    for x = 1:ncolumns
        for y = 1:nrows 
            if I(y,x) <= Th(y,x)
                newIm(y,x) = 0;
            else
                newIm(y,x) = 255;
            end    
        end
    end
   out = newIm;   
end
