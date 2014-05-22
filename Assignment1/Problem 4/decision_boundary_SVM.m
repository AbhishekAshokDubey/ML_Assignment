function decision_boundary_SVM(X, y, model, grid_resolution)
% This function plots the decision boundary for your classifier with respect
% to the training data, labels given. Note that the arguement 

% X - m x 2 matrix of instances (only data sets with 2 features)
% y - m x 1 vector of labels (+1/-1)
% model - SVM model returned by SVM_learner.m
% resolution - 
%     resolution of the grid to be generated: an integer between 10 and
%     100; for more accurate decision boundary, set this to a high value;
%     default value is 50

% Adapted from :
% http://www.mathworks.in/matlabcentral/fileexchange/34864-decision-boundary-using-svms/content/Decision%20Boundary%20using%20SVMs/visualizeBoundary.m
   
if(nargin < 4)
    grid_resolution = 50;
end

disp('Inside Boundary draw');

plot(X(y==1, 1), X(y==1, 2), 'ob'), hold on;
plot(X(y==-1, 1), X(y==-1, 2), 'xr'), hold on,

% Make classification predictions over a grid of values
x1plot = linspace(-1.5, 1.5, grid_resolution)';
x2plot = linspace(-1.5, 1.5, grid_resolution)';
[X1, X2] = meshgrid(x1plot, x2plot);
vals = zeros(size(X1));
for i = 1:size(X1, 2)
   this_X = [X1(:, i), X2(:, i)];
   vals(:, i) = SVM_classifier(this_X, model);
end

%XINP = [-2:0.1:2];
%YINP1 = (-1*model.b - model.w(1).*XINP)/(model.w(2));
%YINP2 = (-1*model.b -1 - model.w(1).*XINP)/(model.w(2));
%YINP3 = (-1*model.b +1 - model.w(1).*XINP)/(model.w(2));
%hold on
%plot(XINP,YINP1,'k');
%plot(XINP,YINP2,'k');
%plot(XINP,YINP3,'k');

% Plot the SVM boundary
hold on
contour(X1, X2, vals, [0 0], 'Color', 'k', 'LineWidth', 3);
xlabel('Feature 1');
ylabel('Feature 2');
legend('Positive Test Examples', 'Negative Test Examples', 'Classifier Boundary');
hold off;
