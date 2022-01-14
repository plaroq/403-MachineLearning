function res = gradF(wHat,xHat,y)

temp =0;
for i = 1:480
    top = (y(i)*exp(-y(i)*wHat'*xHat(i)))*xHat(i);
    bottom = (1+exp(-y(i)*wHat'*xHat(i)));
    temp = temp+ (top/bottom);  
end

res = (-1/480)*temp;