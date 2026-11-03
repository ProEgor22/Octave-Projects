clc
i = 0;
c = 4.1;

while true
  a = str2double(input('Vvedit a = ', 's'));
  b = str2double(input('Vvedit b = ', 's'));

  if isnan(a) || isnan(b) || a >= b
    errordlg('Введено невірні значення!!!', 'Помилка');
    s = input('Bazhaete prodovzhiti? (y/n): ', 's');
    if ~strcmpi(s, 'Y')
      disp('Prohrama zavershena.');
      break;
    else
      continue;
    end
  end

  i = i + 1;
  fprintf('\nRozrahunok %d\n', i);

  h = 0.1 * (b - a);
  x = a:h:b;
  y = exp(-2 * x);
  elem = [];

  for k = 1:size(y, 2)
    if y(1, k) > c
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

  ans_user = input('Bazhaete prodovzhiti?(Y/N) ', 's');
  if ~strcmpi(ans_user, 'Y')
    disp('Prohrama zavershena.');
    break;
  end
end
