clc

while true
  n = inputdlg({'x =', 'Кількість повторів N=', 'Відповідь:'}, 'Варіант 16', 1);
  if isempty(n)
    errordlg('Введіть значення x, N!!!', 'Помилка');
    ans_user = input('Bazhaete prodovzhiti?(Y/N) ', 's');
      if ~strcmpi(ans_user, 'Y')
        disp('Prohrama zavershena.');
        break;
      else
        continue;
      end
  end

  x = str2double(n{1});
  N = str2double(n{2});

  has_div_by_zero = false;
  if ~isnan(x) && ~isnan(N)
    for k = 1:N
      if x + k == 0
        has_div_by_zero = true;
        break;
      end
    end
  end

  if isnan(x) || isnan(N) || x == 0 || N <= 0 || fix(N) ~= N || has_div_by_zero
    errordlg('Введіть коректні числа (x != 0, N > 0)!', 'Помилка');
    ans_user = input('Bazhaete prodovzhiti?(Y/N) ', 's');
      if ~strcmpi(ans_user, 'Y')
        disp('Prohrama zavershena.');
        break;
      else
        continue;
      end
  end

  % Початкове значення першого доданка (1/x) та суми
  term = 1 / x;
  S = term;

  for k = 1:N
    term = term / (x + k); % Рекурентне обчислення наступного доданка
    S = S + term; % Додавання до загальної суми
  end

  x_str = num2str(x);
  N_str = num2str(N);
  S_str = num2str(S, '%.8g');
  inputdlg({'x =', 'Кількість повторів N=', 'Відповідь:'}, ...
            'Варіант 16', 1, {x_str, N_str, S_str});

  ans_user = input('Bazhaete prodovzhiti?(Y/N) ', 's');
  if ~strcmpi(ans_user, 'Y')
    disp('Prohrama zavershena.');
    break;
  end
end
