function j = problem5()
clc;
clear;

C = [0.01; 0.1; 1; 10; 100; 1000; 10000];
kFoldTrainError = zeros(size(C,1),1);
kerneltype = 1;
r = 0;
k = 5;

rawDataTrain = load('spambase/train.txt');
rawDataTest = load('spambase/test.txt');
X = rawDataTrain(:,1:size(rawDataTrain,2)-1);
Y = rawDataTrain(:,size(rawDataTrain,2));
XTest = rawDataTest(:,1:size(rawDataTest,2)-1);
YTest = rawDataTest(:,size(rawDataTest,2));

foldedData = makeNFolds(X,Y,k);

for i=1:size(C,1)
    [kFoldTrainError(i)] = nFoldCrossValidation(k,X,Y,C(i),kerneltype,r,foldedData);
end
j = find(kFoldTrainError == min(kFoldTrainError));
kFoldTrainError

% j=5

model = SVM_learner(X, Y, C(j), kerneltype, r);

predictions = SVM_classifier(X,model);
errorTrain = computeError(Y,predictions);
disp('error on Train data is :');
errorTrain/size(X,1)

predictions = SVM_classifier(XTest,model);
errorTest = computeError(YTest,predictions);
disp('error on Test data is :');
errorTest/size(XTest,1)

end