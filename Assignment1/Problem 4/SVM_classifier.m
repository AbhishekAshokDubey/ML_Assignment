function labels = SVM_classifier(testdata, model)
    % INPUT
    % testdata - m X n matrix of the test data samples
    % model    - SVM model structure returned by SVM_learner
    
    % OUTPUT
    % labels - m x 1 vector of predicted labels
    
    % Write code here
K = compute_kernel(model.support_vectors,testdata,model.kerneltype, model.r);
labels = K'*(model.alphas(model.support_vectors_pos).*model.trainlabels(model.support_vectors_pos)) + model.b;

labels(labels>=0) = 1;
labels(labels<0) = -1;
end

            