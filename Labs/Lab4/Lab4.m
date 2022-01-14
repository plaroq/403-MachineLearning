%Initialization%
close all
clear all
clc

load D_bc_tr.mat
load D_bc_te.mat

Xtrain = zeros(30,480);
for i = 1:30
    xi = D_bc_tr(i,:);
    mi = mean(xi);
    vi = sqrt(var(xi));
    Xtrain(i,:) = (xi - mi)/vi;
end
Xtest = zeros(30,89);
for i = 1:30
    xi = D_bc_te(i,:);
    mi = mean(xi);
    vi = sqrt(var(xi));
    Xtest(i,:) = (xi - mi)/vi;
end     

ytrain = D_bc_tr(31,:);
ytest = D_bc_te(31,:); 


%Calculating wHat%
xHat = [Xtrain' ones(480,1)];
wHat = ((xHat'*xHat)^-1)*(xHat')*ytrain'

%Getting w and b
w = wHat(1:30,:)
b = wHat(31,1)


f = calcF(wHat,xHat,ytrain)

temp = w'*Xtest
