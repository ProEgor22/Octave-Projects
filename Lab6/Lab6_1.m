clc
graphics_toolkit('qt');
function GUI()
vikno = figure('Name', 'Lab6_1 - Варіант 16', ...
               'NumberTitle', 'off', 'Position', [400, 300, 390, 360], ...
               'MenuBar', 'none');
%Рядок 1
uicontrol('Style', 'text', 'String', 'Значення x =', ...
          'Position', [20, 320, 130, 25], 'HorizontalAlignment', 'center');
hx = uicontrol('Style', 'edit', 'Position', [170, 320, 200, 25], 'String', '');
%Рядок 2
uicontrol('Style', 'text', 'String', 'Поточний проміжок:', ...
          'Position', [20, 260, 130, 25], 'HorizontalAlignment', 'center');
hp = uicontrol('Style', 'edit', 'Position', [170, 260, 200, 25], ...
               'Enable', 'inactive');
%Рядок 3
uicontrol('Style', 'text', 'String', 'Поточна функція:', ...
          'Position', [20, 200, 130, 25], 'HorizontalAlignment', 'center');
hf = uicontrol('Style', 'edit', 'Position', [170, 200, 200, 25], ...
               'Enable', 'inactive');
%Рядок 4
uicontrol('Style', 'text', 'String', 'Розв"язок функції:', ...
          'Position', [20, 140, 130, 25], 'HorizontalAlignment', 'center');
hy = uicontrol('Style', 'edit', 'Position', [170, 140, 200, 25], ...
               'Enable', 'inactive');
%Кнопка розв'язку
uicontrol('Style', 'pushbutton', 'String', 'Розрахувати', ...
          'Position', [135, 30, 120, 30], ...
          'CallBack', {@calculate, hx, hp, hf, hy});
end
%Функція розрахунку
function calculate(~, ~, hx, hp, hf, hy)
x = str2double(get(hx, 'String'));
  if isnan(x)
    errordlg('Введіть число!', 'Помилка');
    return
  end
  if x < -2
    y = 2^x * cos(3*x) - tan(1.5*x);
    set(hp, 'String', 'x < -2');
    set(hf, 'String', '2^x * cos(3*x) - tan(1.5*x)');
    set(hy, 'String', num2str(y));
  elseif x > 2
    y = tan(sqrt(x))^2 - 1/(x+2.5);
    set(hp, 'String', 'x > 2');
    set(hf, 'String', 'tan(sqrt(x))^2 - 1/(x+2.5)');
    set(hy, 'String', num2str(y));
  else
    y = 4.1 * acos(x/2) + sqrt(x + 2);
    set(hp, 'String', '-2 =< x =< 2');
    set(hf, 'String', '4.1 * acos(x/2) + sqrt(x + 2)');
    set(hy, 'String', num2str(y));
  end
end
GUI()
