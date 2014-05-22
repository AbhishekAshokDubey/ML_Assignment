function [ output_args ] = perceptron()
% perceptron algorithm along with the plot function for boundary
clc;
dataPath = 'synth2a.txt';
D = load(dataPath);
X = D(:,1:2);
Y = D(:,3);

m = size(X,1);
n = size(X,2);
w = zeros(n,1);
i=1;
errorCount = 0;
correctClassified = 0;
	while correctClassified ~= m
		if((Y(i)*(w'*X(i,:)')) <= 0)
			w = w + Y(i).*X(i,:)';
			errorCount = errorCount+1;
			correctClassified = 0;
			i
		else
			correctClassified = correctClassified +1;
		end    
		i = rem(i,m) +1 ;
	end
w
    plot_boundary(X,Y,w);
end

function plot_boundary(X, Y, w)
clf
m = size(X,1);
	for i=1:m
		if(Y(i)>0)
		plot(X(i,1),X(i,2),'rd');
		else
		plot(X(i,1),X(i,2),'bo');
		end
	hold on
	end
	x = [-0.03:0.01:0.03];
	y = -(w(1)/w(2)).*x;
	plot(x,y);
end