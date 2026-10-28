clc
m = input("Vvedit vektor stovpchik [n1; n2; ...]:\n ");
elem = [];
c = 1.7;

if ~isnumeric(m) || size(m, 2) > 1 || isempty(m)
  errordlg('Введіть числовий вектор стовпчик!!!', 'Помилка');
  s = input('Bazhaete prodovzhiti? (y/n): ', 's');
  if ~strcmpi(s, 'Y')
    disp('Prohrama zavershena.');
    return
  else
    Lab7_2
    return
  end
else
  for k = 1:size(m, 1)
    if m(k, 1) >= c
      elem = [elem, m(k, 1)];
    end
  end
end

n = numel(elem);

if isempty(elem)
  fprintf('Elementiv >= %g ne znaydeno\n', c);
elseif n == 1
  fprintf('Kilkist elementiv >= %g: %g\n\nElement odin, dobutku nemaye\n', ...
       c, n);
else
  fprintf('Kilkist elementiv >= %g: %g\n\nDobutok elementiv: %g\n', ...
       c, n, prod(elem));
end