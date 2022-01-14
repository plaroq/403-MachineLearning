% To implement the gradient descent algorithm.
% Example: [xs,fs,k] = grad_desc('f_rosen','g_rosen',[0; 2],1e-9);
function [xs,fs,k] = grad_desc(fname,gname,x0,epsi)
format compact
format long
k = 1;
xk = x0;
gk = feval(gname,xk);
dk = -gk;
ak = bt_lsearch(xk,dk,fname,gname);
adk = ak*dk;
er = norm(adk);
while er >= epsi,
  xk = xk + adk;
  gk = feval(gname,xk);
  dk = -gk;
  ak = bt_lsearch(xk,dk,fname,gname);
  adk = ak*dk;
  er = norm(adk);
  k = k + 1;
end
disp('solution:')
xs = xk + adk
disp('objective function at solution point:')
fs = feval(fname,xs)
format short
disp('number of iterations performed:')
k