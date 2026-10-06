diary lab2_1.txt
format short g
N=16;
A1=linspace(-(N),N,7)
h=N/3;
A2=-(N):h:N
A3=A1+A2
A4=(cos(A1-A2)).^2+A3.^3
A=[A1;A2;A3;A4]
B=diag(A1)
idx=find(A>-(N)/2 & A<N/2)
values=A(idx)
diary off
