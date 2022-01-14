%_________Initialization__________%
clc 
clear all
close all
load D_build_tr.mat
load D_build_te.mat

%_________Separate Test and Training__________%
Xtr = D_build_tr(1:8,:);
Ytr = D_build_tr(9:10,:);

Xte = D_build_te(1:8,:);
Yte = D_build_te(9:10,:);


%_________Set XHat in the correct format and dimensions__________%
X_Hat = [Xtr' ones(640,1)];
I = eye(9);

%_________Calculate the Pseudo-inverse of X_Hat__________%
%Note, X_wierdcross was calcaulted WITHOUT using pinv%
X_weirdCross = inv(X_Hat'*X_Hat + 0.01*(I))*X_Hat';
WB = X_weirdCross * (Ytr');

%_________Separate Wstar and Bstar__________%
W_Star = WB(1:8, :)
B_Star = WB(9,:)'

%_________Apply Optimized Model__________%
Y = W_Star'*Xte + B_Star;

%_________Calculate the overall relative prediction error__________%
ep = norm(Yte - Y, 'fro')/norm(Yte, 'fro')
fprintf('The overall relative prediction error is %%%f',ep*100)


%_________Plot the two graphs__________%
subplot(2,1,1)
plot(Yte(1,:))
hold on
plot(Y(1,:))
hold off
title('First Row of Yte and Y Comparison')

subplot(2,1,2)
plot(Yte(2,:))
hold on
plot(Y(2,:))
hold off
title('Second Row of Yte and Y Comparison')