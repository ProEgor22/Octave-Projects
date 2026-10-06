format shortg
N=input('N = ');
h=input('Vvedit krok: ');
a=input('Vvedit kut: ');
x=[-N:h:N];
if any(sind(a*x + 9^0) == 0)
    warndlg('Uwaga v masivi e tochki dilenya na 0!');
end
y=(7.5 ./ (8*(x.^2-3*x+4)))+(pi ./ sind(a*x+9^0).^3);
%disp(['x = ', num2str(x)])
%disp(['y = ', num2str(y)])
result=[x;y]
plot(x,y,'b+-')
title('Grafic')
xlabel('x')
ylabel('y')
ylim([-100 100])
grid on
