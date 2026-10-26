clc
a = 9.7;
b = 2.9;
c = -5.8;
printf('Kvadratne rivnyanya: %.1fx^2 + %.1fx + (%.1f) = 0\n', a, b, c);
D = b^2 - 4*a*c;
if D < 0
  n = -1;
elseif D == 0
  n = 0;
else
  n = 1;
end

switch n
  case -1
    y = a - b^5;
    printf('Koreniv nemae (D < 0)\n');
  case 0
    x1 = -b / (2*a);
    y = acot(abs(x1));
    printf('Korin odin x1 = %.3f\n', x1);
  case 1
    x1 = (-b - sqrt(D)) / (2*a);
    x2 = (-b + sqrt(D)) / (2*a);
    y = (x1 + x2)^2;
    printf('Koreni rivnyanya:\n x1 = %.3f\n x2 = %.3f\n', x1, x2);
end

printf('\nKinceva vidpovid:\n y = %.3f\n', y);
