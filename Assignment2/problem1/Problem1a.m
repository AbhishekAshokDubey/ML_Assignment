function model = Problem1a()

% The following program uses LIBSVM which can be downloaded from
% http://www.csie.ntu.edu.tw/~cjlin/libsvm/
% For copyright read: http://www.csie.ntu.edu.tw/~cjlin/libsvm/COPYRIGHT

nuValues = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7];
errors = zeros(1,size(nuValues,2));
[Ytrain,Xtrain] = libsvmread('Spambase.libsvm.train.txt');
[Ytest,Xtest] = libsvmread('Spambase.libsvm.test.txt');

size(Ytrain)
size(Ytest)

for i = 1:size(nuValues,2)
    model = svmtrain(Ytrain,Xtrain, strcat({'-s 2 -n '},num2str(nuValues(i))));
    SVs(i) = size(model.SVs,1)
    [prediction accuracy decisionvalue] = svmpredict(Ytest,Xtest,model);
    errors(i) = computeError(prediction,Ytest);
end
errors = errors/size(Ytrain,1)
plot(nuValues,errors);
hold on
SVs = SVs/size(Ytrain,1)
plot(nuValues,SVs);
end

