function [OutputImage] = ImageInpainting(sampleImage, image, winSize)
winSize = 9; 
tic;
maxErrThreshold = 0.3;

image = imread('C:\Users\J.Suresh kumar\Desktop\2nd sem\Vision\ass2\images\test_im1.bmp');

figure
imshow(uint8(image))
testImage = zeros(size(image,1), size(image,2));
while min(min(image)) == 0
    progress = 0;
    pixelList = getUnfilledNeighbors(image, winSize);
    size(pixelList)
    for p = 1:size(pixelList,1)
        
        template = getNeighborhoodWindow(pixelList(p,:), image, winSize);
        sampleImage = getNeighborhoodWindow(pixelList(p,:), image, s);
        sampleImage( :, ~any(sampleImage,1) ) = [];
        sampleImage( ~any(sampleImage,2), : ) = [];
        [bestMatches, errors] = fMatches(template, sampleImage, winSize);
        if(sum(sum(bestMatches))==0)
            
        end
        if (sum(sum(bestMatches))~=0)
            index = randi(size(bestMatches,1));
            bestMatch = bestMatches(index);
            if (errors(index) < maxErrThreshold)
                if bestMatch ~= 0
                    image(pixelList(p, 1), pixelList(p,2)) = bestMatch;
                    progress = 1;
                end
            end
        end
        
        imshow(uint8(image))
        
    end
    if (progress == 0)
        maxErrThreshold = maxErrThreshold * 1.1;
    end
end
toc
end


