function pixelList = getUnfilledNeighbors(image, windowSize)

imgMask = image > 0;

se = strel('square', 3);

dil = imdilate(imgMask, se);

unfilledNeighbors = (dil - imgMask) > 0;

size(unfilledNeighbors);
PL = [];
nFilled = [];
for x=1 : size(unfilledNeighbors, 1)
    for y = 1 : size(unfilledNeighbors,2)
        if unfilledNeighbors(x,y)
            index = size(PL, 1) + 1;
            PL(index,:) = [x ;y];
            
            z=getNeighborhoodWindow([x;y],image, windowSize);
            nFilled(index,:) = numel(find(z~=-1));
            
        end
    end
end
pixelList = sortrows(horzcat(PL,nFilled),-3);
pixelList(:,3)= [];

end