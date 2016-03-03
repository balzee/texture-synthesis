function [OutputImage] = ImageSynthesis(sampleImage, image, windSize)
windSize = 9;
tic;
maxErrThreshold = 0.3;

sampleImage = imread('C:\Users\J.Suresh kumar\Desktop\2nd sem\Vision\ass2\images\T1.gif');

[u,v] = size(sampleImage);
image = repmat(-1,200,200);
image((100-fix(u/2)):(100-fix(u/2))+u-1, (100-fix(v/2)):(100-fix(v/2))+v-1) = sampleImage;

figure
imshow(uint8(image))
while min(min(image)) < 0
    progress = 0;
    pixelList = getUnfilledNeighbors(image, windSize);
    size(pixelList)
    for u = 1:size(pixelList,1)

        template = getNeighborhoodWindow(pixelList(u,:), image, windSize);
        [bestMatches, errors] = findMatches(template, sampleImage, windSize);
        index = randi(numel(find(bestMatches~=-1)));
        bestMatch = bestMatches(index);
     
        if (errors(index) < maxErrThreshold)
           image(pixelList(u, 1), pixelList(u,2)) = bestMatch;
           progress = 1;
        end        
        imshow(uint8(image))
        
    end
    if (progress == 0)
            maxErrThreshold = maxErrThreshold * 1.1;
    end
end
toc
end
