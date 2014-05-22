function [errorSum] = nFoldCrossValidation(k,X,Y,C,kerneltype,r)

foldedData = makeNFolds(X,Y,k);
errorSum = 0;

for i=1:k
    Xtest =[];
    Ytest =[];
    Xtrain = [];
    Ytrain = [];
    for j=1:k
        if i~=j
            Xtrain = [Xtrain ; X(foldedData.bins(j,:),:)];
            Ytrain = [Ytrain ; Y(foldedData.bins(j,:),:)];
        else
            Xtest = X(foldedData.bins(j,:),:);
            Ytest = Y(foldedData.bins(j,:),:);
        end
    end
%     size(Xtrain)
%     size(Ytrain)
    model = SVM_learner(Xtrain, Ytrain, C, kerneltype, r);
%     size(Xtest)
%     size(model.traindata)
    labels = SVM_classifier(Xtest, model);
	error = computeError(labels,Ytest);
    errorSum = errorSum + error;
end

errorSum = errorSum/k;
end