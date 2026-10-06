clc
x = linspace(-sqrt(6), sqrt(6), 100);
y1=(28-x)/9;
y2_top = sqrt(6 - x.^2) - 2;      % Верхня півсфера
y2_bottom = -sqrt(6 - x.^2) - 2;  % Нижня півсфера
plot(x, y1, 'r-', x, y2_top, 'b-', x, y2_bottom, 'b-');
title('Graphic');
xlabel('x');
ylabel('y');
axis equal;
grid on
% === БЛОК ІНТЕРПОЛЯЦІЇ ДЛЯ МАСИВІВ ===

% 1. Розрахунок різниць між прямою та півсферами
D_top = y1 - y2_top;
D_bottom = y1 - y2_bottom;

% 2. Пошук індексів, де різниця змінює знак (перетин)
cross_top = find(D_top(1:end-1) .* D_top(2:end) <= 0);
cross_bottom = find(D_bottom(1:end-1) .* D_bottom(2:end) <= 0);

has_intersection = false;

% 3. Обробка верхньої півсфери
for k = 1:length(cross_top)
    i = cross_top(k);
    x_int = interp1(D_top(i:i+1), x(i:i+1), 0, 'linear');
    y_int = interp1(x(i:i+1), y1(i:i+1), x_int, 'linear');
    fprintf('Znaydeno peretin z verhnyoyu pivsferoyu: x = %.6f, y = %.6f\n', x_int, y_int);
    has_intersection = true;
end

% 4. Обробка нижньої півсфери
for k = 1:length(cross_bottom)
    i = cross_bottom(k);
    x_int = interp1(D_bottom(i:i+1), x(i:i+1), 0, 'linear');
    y_int = interp1(x(i:i+1), y1(i:i+1), x_int, 'linear');
    fprintf('Znaydeno peretin z nijnyoyu pivsferoyu: x = %.6f, y = %.6f\n', x_int, y_int);
    has_intersection = true;
end

if ~has_intersection
    disp('Tochok peretinu ne znaydeno.');
end
