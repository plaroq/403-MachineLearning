clc
clear all
close all

load D_iris.mat

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

y1 = [ones(40,1); -ones(80,1)];
y2 = [ones(40,1); -ones(80,1)];
y3 = [ones(40,1); -ones(80,1)];

p1 = Xtr1;
p2 = Xtr2;
p3 = Xtr3;

n1 = [Xtr2 Xtr3];
n2 = [Xtr1 Xtr3];
n3 = [Xtr1 Xtr2];

xh1 = [[p1 n1]' ones(120,1)];
xh2 = [[p2 n2]' ones(120,1)];
xh3 = [[p3 n3]' ones(120,1)];

wh1 = ((xh1'*xh1)^-1)*(xh1')*y1;
wh2 = ((xh2'*xh2)^-1)*(xh2')*y2;
wh3 = ((xh3'*xh3)^-1)*(xh3')*y3;

ws1 = wh1(1:4,:);
ws2 = wh2(1:4,:);
ws3 = wh3(1:4,:);

bs1 = wh1(5,1);
bs2 = wh2(5,1);
bs3 = wh3(5,1);

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

confuse2=zeros(3,3);

for i=1:3
    confuse2(i,1)=sum(confuse(i,1:10));
    confuse2(i,2)=sum(confuse(i,11:20));
    confuse2(i,3)=sum(confuse(i,21:30));
end

confuse2

sumErr = confuse2;

for i=1:3
    sumErr(i,i)=0;
end

percentErr = 100* sum(sumErr,'all')/30