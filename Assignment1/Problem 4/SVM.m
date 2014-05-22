function SVM()
D = load('synth1b.txt');
n = size(D,2);
traindata = D(:,1:n-1);
trainlabels = D(:,n);
C = 10;
kerneltype = 2;
r = 3;

C = [0.01 0.1 1 10];
kType = [1 1 1 1];
rVal = [0 0 0 0];

for i=1:4
model = SVM_learner(traindata, trainlabels, C(i), kType(i), rVal(i));
figure(i);
decision_boundary_SVM(traindata, trainlabels, model,100);
end
end