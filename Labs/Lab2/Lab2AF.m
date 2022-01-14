%_____Initialization_____%
clc
clear all
close all

load D_iris.mat

%_____Separation of Data_____%
%Provided in Lab Manual 
D = D_iris(1:4,:);
X1 = D(:,1:50);
X2 = D(:,51:100);
X3 = D(:,101:150);

rand('state',111)
r1 = randperm(50);
Xtr1 = X1(:,r1(1:40));
Xte1 = X1(:,r1(41:50)); 

rand('state',112)
r2 = randperm(50);
Xtr2 = X2(:,r2(1:40));
Xte2 = X2(:,r2(41:50));
rand('state',113)
r3 = randperm(50);
Xtr3 = X3(:,r3(1:40));
Xte3 = X3(:,r3(41:50));


[ws1,bs1] = linear(Xtr1,Xtr2,Xtr3);
[ws2,bs2] = linear(Xtr2,Xtr1,Xtr3);
[ws3,bs3] = linear(Xtr3,Xtr1,Xtr2);

XteTotal = [Xte1 Xte2 Xte3];

y1 = (ws1')*XteTotal+bs1;
y2 = (ws2')*XteTotal+bs2;
y3 = (ws3')*XteTotal+bs3;

Y = [y1;y2;y3];

confuse = zeros(3,30);

[C,I]=max(Y);

for i=1:30
    if I(i)==1
        confuse(1,i)=confuse(1,i)+1;
    elseif I(i)==2
        confuse(2,i)=confuse(2,i)+1;
    else
        confuse (3,i)=confuse(3,i)+1;
    end
end
confuse

confuseCompact=zeros(3,3);

for i=1:3
    confuseCompact(i,1)=sum(confuse(i,1:10));
    confuseCompact(i,2)=sum(confuse(i,11:20));
    confuseCompact(i,3)=sum(confuse(i,21:30));
end

confuseCompact

sumErr = confuseCompact;

for i=1:3
    sumErr(i,i)=0;
end

percentErr = 100* sum(sumErr,'all')/30;
fprintf('Classification complete with %0.2f%% percent error\n',percentErr);



function [w_Star, b_Star] = linear(D1,D2,D3)
    y = [ones(40,1); -ones(80,1)];
    p = D1;
    n = [D2 D3];

    xHat = [[p n]' ones(120,1)];
    wHat = ((xHat'*xHat)^-1)*(xHat')*y;

    w_Star = wHat(1:4,:);
    b_Star = wHat(5,1);
end
