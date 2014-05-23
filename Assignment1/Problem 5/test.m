function test()

% C = [0.01, 0.1, 1, 10, 100, 1000, 10000];
% kerneltype = [1,2,3];
% rPoly = [2, 3];
% rRBF = [1,1/32, 1/4, 4, 32];
% k = 5;
% noOfPossibleParameters = size(C,2)*(1+size(rPoly,2)+size(rRBF,2));
% kFoldTrainError = zeros(noOfPossibleParameters,1);

trainingData = load('synth3/train.txt');
X = trainingData(:,1:size(trainingData,2)-1);
Y = trainingData(:,size(trainingData,2));

testData = load('synth3/test.txt');
XTest = testData(:,1:size(testData,2)-1);
YTest = testData(:,size(testData,2));

% Linear kernel : Test error: 0.13, Best C = 10.
% Polynomial kernel: Test error: 0.13, Best parameters: C = 100; d = 3.
% RBF kernel : Test error: 0.08, Best parameter: C = 10; sigma = 1/4.

%model = SVM_learner(X, Y, C(j), kerneltype, r);

model = SVM_learner(X, Y, 10, 1, 0);
%model = SVM_learner(X, Y, 100, 2, 3);
%model = SVM_learner(X, Y, 10, 3, 0.25);

predictions = SVM_classifier(X,model);
errorTrain = computeError(Y,predictions);
disp('error on Train data is :');
errorTrain/size(X,1)

% CorrectTrain = compuateCorrect(Y,predictions);
% errorTrain
% CorrectTrain
% size(X,1)

predictions = SVM_classifier(XTest,model);
errorTest = computeError(YTest,predictions);
disp('error on Test data is :');
errorTest/size(XTest,1)
end