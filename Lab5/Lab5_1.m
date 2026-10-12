clc
x = inputdlg({'Rebro kuba a =', 'Obyem kuba V =', 'Plosha bichnoi poverhni S ='}, 'Variant N16', 1);
a = str2double(x(1));
V = a^3;
S = 6*a^2;
a = num2str(a);
V = num2str(V);
S = num2str(S);
x = inputdlg({'Rebro kuba a =', 'Obyem kuba V =', 'Plosha bichnoi poverhni S ='}, 'Variant N16', 1, {a, V, S});
