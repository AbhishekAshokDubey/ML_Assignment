function model = SVM_learner(traindata, trainlabels, C, kerneltype, r)
X = traindata;
Y = trainlabels;
m = size(X,1);
n = size(X,2);

% Here is reason to all
% Final objective function max(f) as quadprog minimizes so we do so min(-f)
% -f = 1/2 (SumOverI SumOverJ aiaj yiyj kernel(xixj)) - sumOverI ai;
% rest all become zero in different derivatives
%  Subjected to
% sumOverI aiyi = 0
% ai >= 0 for all i
% ai <=c for all i
H = [];
for i=1:m
temp = [];
	for j=1:m
		temp = [temp (Y(i)*Y(j)*compute_kernel(X(i,:),X(j,:),kerneltype,r))];
	end
	H =[H; temp];
end

f = -1*ones(m,1);
A = [-1*eye(m); eye(m)];
b =[zeros(m,1); C*ones(m,1)]
Aeq = Y';
beq = 0;

[alpha,fval,exitflag,output,lambda] = quadprog(H,f,A,b,Aeq,beq)
objective = -fval;

%w = alpha'.*Y'*X;


%Support vectors are ai which are not zero, which contribute in w
SVMAT =[];
SVMATPos = [];

for i=1:m
	if(alpha(i)>0)
		SVMAT = [SVMAT; X(i,:)];
		SVMATPos = [SVMATPos; i];
	end
end

%SVMATPos

% for computing b, we must note that when 0 < ai < C, in this case, yi(wTxi+b) = 1
% In kernel SVM we dun know the W
count = 0;
b = 0;
for i=1:m
	if(alpha(i)>0 && alpha(i)<C)
%		b = 1/Y(i) - w'*X(i,:);
		K = compute_kernel(SVMAT,X(i,:),kerneltype,r);
		b = b + 1/Y(i) - (K'*(alpha(SVMATPos).*trainlabels(SVMATPos)))
		count = count + 1;
	end
end

b = b/count;

    model.b = b;
    model.objective = objective;
    model.alphas = alpha; 
    model.kerneltype = kerneltype;
    model.r = r;
    model.C = C;
    model.traindata = traindata;
    model.trainlabels = trainlabels;
    model.support_vectors = SVMAT;
	model.support_vectors_pos = SVMATPos;
	
	% INPUT :  
    % traindata   - m X n matrix, where m is the number of training points
    % trainlabels - m X 1 vector of training labels for the training data
    % C           - SVM regularization parameter (positive real number)
    % kerneltype  - one of strings 'linear', 'poly', 'rbf'
    %               corresponding to linear, polynomial, and RBF kernels
    %               respectively.
    % r           - integer parameter indicating the degree of the
    %               polynomial for polynomial kernel, or the width
    %               parameter for the RBF kernel; not used in the case of
    %               linear kerne and can be set to a default value.
    
    % OUTPUT
    % returns the structure 'model' which has the following fields, in
    % addition to the training data/parameters.(You can choose to add more
    % fields to this structure needed for your implementation)
    
    
    % 	alphas      	- m X 1 vector of support vector coefficients
    % 	b           	- SVM bias term
    % 	objective   	- optimal objective value of the SVM solver
    % 	support_vectors - the subset of training data, which are the support vectors
    
    % Default code below. Fill in the code for solving the
    % SVM dual optimization problem using quadprog function
end