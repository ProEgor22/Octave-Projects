clc
a = input('Vvedit a = ');
b = input('Vvedit b = ');

if isempty(a) || isempty(b) || ~isnumeric(a) || ~isnumeric(b) || a >= b
  errordlg('Значення "a" має бути меншим за "b" i обидва мають бути числами!', 'Помилка');
  s = input('Bazhaete prodovzhiti? (y/n): ', 's');
  if ~strcmpi(s, 'Y')
    disp('Prohrama zavershena.');
    return
  else
    Lab7_3
    return
  end
end

h = 0.1 * (b - a);
x = a:h:b;
y = exp(-2 * x);
elem = [];

for k = 1:size(y, 2)
  if y(1, k) > 4.1
    elem = [elem, y(1, k)];
  end
end

n = numel(elem);

if isempty(elem)
  fprintf('Elementiv > 4.1 ne znaydeno\n');
elseif n == 1
  fprintf('Kilkist elementiv > 4.1: %g\n\nElement odin, dobutku nemaye\n', n);
else
  fprintf('Kilkist elementiv > 4.1: %g\n\nDobutok elementiv: %g\n', n, prod(elem));
end