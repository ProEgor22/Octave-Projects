pkg load optim
% Встановлюємо графічний інструментарій Qt
graphics_toolkit('qt');

function GUI()
  % 1. Створення головного вікна
  fig = figure('Name', 'Оптимізація виробництва БПЛА', ...
               'Position', [200, 200, 480, 450], ...
               'NumberTitle', 'off', ...
               'MenuBar', 'none');

  % Заголовок вікна
  uicontrol('Style', 'text', 'Position', [10, 415, 460, 25], ...
            'String', 'Оптимізація виробництва БПЛА', ...
            'FontSize', 11, 'FontWeight', 'bold', ...
            'BackgroundColor', [0.85 0.9 0.95], ...
            'HorizontalAlignment', 'center');

  % 2. Поля введення даних
  uicontrol('Style', 'text', 'Position', [40, 370, 110, 20], ...
            'String', 'Прибуток f', 'HorizontalAlignment', 'left');
  h_f = uicontrol('Style', 'edit', 'Position', [160, 370, 200, 25], ...
                  'String', '');

  uicontrol('Style', 'text', 'Position', [40, 330, 110, 20], ...
            'String', 'Матриця A', 'HorizontalAlignment', 'left');
  h_A = uicontrol('Style', 'edit', 'Position', [160, 330, 200, 25], ...
                  'String', '');

  uicontrol('Style', 'text', 'Position', [40, 290, 110, 20], ...
            'String', 'Запаси b', 'HorizontalAlignment', 'left');
  h_b = uicontrol('Style', 'edit', 'Position', [160, 290, 200, 25], ...
                  'String', '');

  % 3. Поля виведення результатів
  uicontrol('Style', 'text', 'Position', [40, 170, 110, 20], ...
            'String', 'БПЛА-А, x1', 'HorizontalAlignment', 'left');
  h_x1 = uicontrol('Style', 'edit', 'Position', [170, 170, 100, 25], ...
                   'Enable', 'inactive');

  uicontrol('Style', 'text', 'Position', [40, 130, 110, 20], ...
            'String', 'БПЛА-Б, x2', 'HorizontalAlignment', 'left');
  h_x2 = uicontrol('Style', 'edit', 'Position', [170, 130, 100, 25], ...
                   'Enable', 'inactive');

  uicontrol('Style', 'text', 'Position', [40, 90, 120, 20], ...
            'String', 'Прибуток, тис. грн', 'HorizontalAlignment', 'left');
  h_fval = uicontrol('Style', 'edit', 'Position', [170, 90, 100, 25], ...
                     'Enable', 'inactive');

  % 4. Рядок відображення статусу
  h_status = uicontrol('Style', 'text', 'Position', [40, 30, 400, 25], ...
                       'String', '', ...
                       'FontSize', 10, ...
                       'FontWeight', 'bold', ...
                       'HorizontalAlignment', 'left');

  % 5. Кнопка "Розрахувати"
  uicontrol('Style', 'pushbutton', 'Position', [160, 235, 100, 30], ...
            'String', 'Розрахувати', ...
            'Callback', {@calculate, h_f, h_A, h_b, h_x1, h_x2, ...
            h_fval, h_status});
end

function calculate(~, ~, h_f, h_A, h_b, h_x1, h_x2, h_fval, h_status)

  f = str2num(get(h_f, 'String'));
  A = str2num(get(h_A, 'String'));
  b = str2num(get(h_b, 'String'));

  if isempty(f) || isempty(A) || isempty(b)
    set(h_status, 'String', 'Помилка: Введіть коректні числові дані!', ...
        'ForegroundColor', [0.8 0 0]);
    return;
  end

  try
    c = f(:);                           % Вектор-стовпець коефіцієнтів прибутку
    ctype = repmat('U', size(A,1), 1);  % 'U' (Upper) задає нерівності типу A*x <= b
    vartype = repmat('I', numel(c), 1); % 'I' (Integer) вимагає строго цілочисельних x
    sense = -1;                         % -1 вказує на шуканий МАКСИМУМ (-1 = max, 1 = min)
    lb = zeros(size(c));                % Нижня межа x >= 0 (неможливо створити < 0 БПЛА)
    ub = [];                            % Верхня межа відсутня

    [x, fval, status] = glpk(c, A, b, lb, ub, ctype, vartype, sense);

    if status == 0
      set(h_x1, 'String', num2str(x(1)));
      set(h_x2, 'String', num2str(x(2)));
      set(h_fval, 'String', num2str(fval));
      set(h_status, 'String', 'Розв’язок знайдено!', ...
          'ForegroundColor', [0 0.5 0]);
    else
      set(h_status, 'String', 'Розв’язок не знайдено!', ...
          'ForegroundColor', [0.8 0 0]);
    end

  catch ME
    set(h_status, 'String', ['Помилка: ' ME.message], ...
        'ForegroundColor', [0.8 0 0]);
  end
end

GUI()
