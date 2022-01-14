%__________Experiment1__________%
load X1600.mat
load Te28.mat
load Lte28.mat
%__________TEST
%p0=X1600(:,1:1600);
%A=reshape(p0(:,1),28,28);
%imshow(A);

%__________Initialization__________%
q = 29;         %Number of principal axes (As instructed in Lab Manual 
size = 1600;    %number of samples for each set of digits
test_size = 10000;  %number of test samples
correct = 0;     %Counter for matched img
error = 0;

%Separate all the testing data for each invidual number
%1600 columns are tests data for each number. 
for i = 1:10    %itterate for each number 0 to 9
    %Get data set for first number
    X = X1600(:,((i-1)*size+1):size*i);
    
    %Compute the mean of the first element of all 1600 set of the number.
    %Transpose again to get 784x1 = a single 28x28 img of all 1600 numbers 
    %averaged together.
    mu(:,:,i) = mean(X')';
    
    %Data matrix. 
    A = X-mu(:,:,i);
    
    %Compute Covariance matrix C = (1/m)A*A_transpose
    C = (1/size)*A*(A');
    
   [Uq(:,:,i), Sq] = eigs(C,q);
     
end

%Start Time
startTime = cputime;    
%Comparing to testing set
for j=1:10
    %Using equation in CH1 pg13, step3 f=Uq_transpose*(x-u), x=testSet
    %Calculating Principal Component
    f=Uq(:,:,j)' * (Te28-mu(:,:,j));     %E1.4 in Lab Manual
    x_hat=Uq(:,:,j)*f + mu(:,:,j);       %E1.5 in Lab Manual
        for k = 1:test_size
            e(k,j)=norm(Te28(:,k)-x_hat(:,k));

        end
end

%find minimum dist
[e_min,index] = min(e');
result = (index')-1;  
endTime = cputime;      %End Time

for a = 1:test_size
    %Compare result to Lte28.mat
    if result(a) == Lte28(a)
        correct = correct + 1;
    else 
        error = error + 1;
        fprintf('The training set failed to identify element %d, which is the number: %d\n',a, Lte28(a));
    end
   
end
totalTime = (endTime - startTime);
correctPercent = (correct/test_size)*100;
errRate = (error/test_size)*100;
fprintf('The accuracy is: %.2f%%\n', correctPercent);
fprintf('The error rate is: %.2f%%\n', errRate)
fprintf('The time required for steps 3-6 is: %.2f seconds\n',totalTime);


