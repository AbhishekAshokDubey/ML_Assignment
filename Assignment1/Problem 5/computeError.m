function error = computeError(labels,predictions)
    error = predictions + labels;
    error = size(find(error==0),1);
end