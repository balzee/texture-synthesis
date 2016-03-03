function [bestMatches, errors] = fMatches(template, sampleImage, windowSize)
errThreshold = 0.3;
validMask = (template ~= 0);
sigma = windowSize/6.4;
gaussMask = fspecial('gaussian', windowSize, sigma);
totalWeight = sum(sum(gaussMask .* validMask));
paddedSampleImage = padarray(sampleImage, [fix(windowSize/2),fix(windowSize/2)]);
SSD = zeros(size(sampleImage,1), size(sampleImage,2));
for i = 1:size(sampleImage,1)
    for j = 1: size(sampleImage,2)
        dist = (double(template) - double(paddedSampleImage(i:i+windowSize-1, j:j+windowSize-1))).^2;
        SSD(i,j) = SSD(i,j) + sum(sum(dist .* validMask .* gaussMask));
    end
end
SSD = SSD ./ totalWeight;
temp = SSD;
temp(temp == 0) = 10000;
[row, column] = find(SSD <= (min(min(temp))*(1+errThreshold)));
positions = [row, column];
bestMatches = zeros(size(positions,1),1);
errors = zeros(size(positions,1),1);
for i = 1:size(positions,1)
    bestMatches(i,:) = sampleImage(row(i), column(i));
    errors(i,:) = SSD(row(i), column(i)) - min(min(temp))*(1+errThreshold);
end
end