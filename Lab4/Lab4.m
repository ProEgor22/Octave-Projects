clc
format shortg
pkg load statistics
N=input('Vvedit N = ');
A1=linspace(-3*N,8*N,30);
h1=((2*N)-1)/14;
h2=((N/2)-(-N/2))/14;
h3=((N+10)-(N-10))/14;
A2=[1:h1:2*N; -N/2:h2:N/2; N-10:h3:N+10];
B1=10*randn(1,30);
B2=10*randn(3,15);
k=0;
start=true;
while start
  k=k+1;
  if k > 1
    ans_user = input('Bazhaete prodovzhiti?(Y/N) ', 's');
      if ~strcmpi(ans_user, 'Y')
        disp('Prohrama zavershena.');
        break;
      end
  end
  punkt=input('Vvedit bazhanyi punkt(1, 2, 3.3, 4, Wilcoxon_test(5)) ');
switch punkt
  case 1
  clc
  printf('\n/////////MATRIX/////////\n\n')
  A1
  A2
  B1
  B2
  printf('\n/////////Max/////////\n\n')
  A1max=max(A1)
  A1B1max=max(A1,B1)
  [H1max,I1max]=max(A1)
  A2max=max(A2)
  A2B2max=max(A2,B2)
  [H2max,I2max]=max(A2)
  A2max1=max(A2,[],1)
  A2max2=max(A2,[],2)
  printf('\n/////////Min/////////\n\n')
  A1min=min(A1)
  A1B1min=min(A1,B1)
  [H1min,I1min]=min(A1)
  A2min=min(A2)
  A2B2min=min(A2,B2)
  [H2min,I2min]=min(A2)
  A2min1=min(A2,[],1)
  A2min2=min(A2,[],2)

  case 2
  clc
  printf('\n/////////MATRIX/////////\n\n')
  A1
  A2
  printf('\n//////////MEAN//////////\n\n')
  A1mn=mean(A1)
  A2mn1=mean(A2)
  A2mn2=mean(A2,1)
  A2mn3=mean(A2,2)
  printf('\n/////////MEDIAN/////////\n\n')
  A1md=median(A1)
  A2md1=median(A2)
  A2md2=median(A2,1)
  A2md3=median(A2,2)
  printf('\n///////////STD//////////\n\n')
  A1std1=std(A1)
  A1std2=std(A1,0)
  A1std3=std(A1,1)
  A2std1=std(A2)
  A2std2=std(A2,0)
  A2std3=std(A2,1)
  A2std4=std(A2,0,1)
  A2std5=std(A2,0,2)
  A2std6=std(A2,1,1)
  A2std7=std(A2,1,2)

  case {3, 3.3}
  clc
  printf('\n/////////MATRIX/////////\n\n')
  A11=[A1+B1*i]
  A12=[A1-B1*i]
  A3=[A1;A11;A12]
  printf('\n////////CPLXPAIR////////\n\n')
  A1112cp=cplxpair([A11,A12])
  A3cp1=cplxpair(A3)
  A3cp2=cplxpair(A3,[],1)
  A3cp3=cplxpair(A3',[],2)

  case 4
  clc
  printf('\n/////////MATRIX/////////\n\n')
  A1
  A2
  printf('\n///////////SUM//////////\n\n')
  A1sum=sum(A1)
  A2sum1=sum(A2)
  A2sum2=sum(A2,1)
  A2sum3=sum(A2,2)
  printf('\n//////////PROD//////////\n\n')
  A1prd=prod(A1)
  A2prd1=prod(A2)
  A2prd2=prod(A2,1)
  A2prd3=prod(A2,2)
  printf('\n/////////CUMSUM/////////\n\n')
  A1csum=cumsum(A1)
  A2csum1=cumsum(A2)
  A2csum2=cumsum(A2,1)
  A2csum3=cumsum(A2,2)
  printf('\n////////CUMPROD/////////\n\n')
  A1cprd=cumprod(A1)
  A2cprd1=cumprod(A2)
  A2cprd2=cumprod(A2,1)
  A2cprd3=cumprod(A2,2)
  printf('\n//////////DIFF//////////\n\n')
  A1df=diff(A1)
  A2df=diff(A2)

  case 5
  clc
  [P, H]=signrank(A1, A1B1max);
  printf('p-znachennya kriteriyu Wilcoxona: %.4f\n', P)
  if H==1
    disp('Visnovok: p < 0.05. The null hypothesis is rejected')
  else
    disp('Visnovok: p > 0.05. The null hypothesis is accepted')
  endif

otherwise
  disp('Nevirnyi punkt! Vyberit 1, 2, 3.3 abo 4.');
  end
end
%Zrobiti z punktu 1, 2, 3.3, 4
