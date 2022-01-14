function res = calcF(wHat,xHat,y)

temp = 0
for i = 1:480
    temp = temp + log(1+exp(-y(i)*wHat'*xHat(i)));  
end

res = (1/480)*temp;

%log(1+exp(-y(i)*wHat'*xHat(i))); 
