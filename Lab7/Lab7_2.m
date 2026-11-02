clc
c = 1.7;
i = 0;

while true
  m = input("\nVvedit vektor stovpchik [n1; n2; ...]:\n");
  elem = [];

  if ~isnumeric(m) || size(m, 2) > 1 || isempty(m) || ~isreal(m)
    errordlg('Введіть числовий вектор стовпчик!!!', 'Помилка');
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

  for k = 1:size(m, 1)
    if m(k, 1) >= c
      elem = [elem, m(k, 1)];
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

  ans_user = input('Bazhaete prodovzhiti?(Y/N) ', 's');
  if ~strcmpi(ans_user, 'Y')
    disp('Prohrama zavershena.');
    break;
  end
end
