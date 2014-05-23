function correct = compuateCorrect( labels,predictions )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
correct = 0;
m = size(labels,1);
for i = 1:m
    if (labels(i)==predictions(i))
        correct = correct +1;
    end
end

end

