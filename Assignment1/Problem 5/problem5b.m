function kFoldTrainError = problem5b()

clc;
clear;

tic;

C = [0.01, 0.1, 1, 10, 100, 1000, 10000];
kerneltype = [1,2,3];
rPoly = [2, 3];
rRBF = [1,1/32, 1/4, 4, 32];
k = 5;
noOfPossibleParameters = size(C,2)*(1+size(rPoly,2)+size(rRBF,2));
kFoldTrainError = zeros(noOfPossibleParameters,1);

rawDataTrain = load('synth3/train.txt');
rawDataTest = load('synth3/test.txt');
X = rawDataTrain(:,1:size(rawDataTrain,2)-1);
Y = rawDataTrain(:,size(rawDataTrain,2));
XTest = rawDataTest(:,1:size(rawDataTest,2)-1);
YTest = rawDataTest(:,size(rawDataTest,2));

foldedData = makeNFolds(X,Y,k);

totalLoopCount = 0;
for i = 1:size(kerneltype,2)
    r = 1;
    if i == 2
        r = rPoly;
    elseif i == 3
        r = rRBF;
    end
    for j = 1:size(r,2)
        for l = 1:size(C,2)
            totalLoopCount = totalLoopCount + 1;
            [kFoldTrainError(totalLoopCount)] = nFoldCrossValidation(k,X,Y,C(l),kerneltype(i),r(j),foldedData);
        end
    end
end

toc

%j = find(kFoldTrainError == min(kFoldTrainError));
% kFoldTrainError;

% model = SVM_learner(X, Y, C(j), kerneltype, r);
% 
% predictions = SVM_classifier(X,model);
% errorTrain = computeError(Y,predictions);
% disp('error on Train data is :');
% errorTrain/size(X,1)
% 
% predictions = SVM_classifier(XTest,model);
% errorTest = computeError(YTest,predictions);
% disp('error on Test data is :');
% errorTest/size(XTest,1)

end

