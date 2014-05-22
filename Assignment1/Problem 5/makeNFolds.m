function foldedData = makeNFolds(X,Y,k)

m = size(X,1);

% Each row of bins will have the indicies of the datarow assigned to that bin
bins = zeros(k,ceil(m/5));
% Count of number of elements in a bin
binCount = zeros(k,1);

for i=1:m
    binNo = floor(rem(rand()*1000,k)+1);
    while binCount(binNo) >= ceil(m/5)
        binNo = floor(rem(rand()*1000,k)+1);
    end
    binCount(binNo) = binCount(binNo) + 1;
    bins(binNo, binCount(binNo)) = i;
end

foldedData.bins = bins;
foldedData.binCount = binCount;
foldedData.k = k;
foldedData.X = X;
foldedData.Y = Y;
end