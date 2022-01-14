load X1600.mat;
load Te28.mat;
load Lte28.mat;

for j=1:10
    X(:,:,j)=X1600(:,(j-1)*1600+1:j*1600);
    mu(:,:,j)=mean(X(:,:,j)')';
    A(:,:,j)=X(:,:,j)-mu(:,:,j);
    C(:,:,j)=A(:,:,j)*A(:,:,j)'/1600;
    [Uq(:,:,j),Sq(:,:,j)]=eigs(C(:,:,j),29);
end

start=cputime;

for j=1:10
    F(:,:,j)=Uq(:,:,j)'*(Te28(:,:)-mu(:,:,j));
    XHat(:,:,j)=Uq(:,:,j)*F(:,:,j)+mu(:,:,j);
    for k=1:10000
        E(k,j)=norm(Te28(:,k)-XHat(:,k,j));
    end
end

[EMin, I] = min(E');
answer = I'-1;
succ=0;
err=0;

for j=1:10000
    if answer(j) == Lte28(j)
        succ=succ+1;
    else
        err=err+1;
    end
end

stop=cputime;
totalTime=stop-start;

succRate = succ/10000*100;
errRate = err/10000*100;