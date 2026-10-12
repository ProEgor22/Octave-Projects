<h1 align="center">Лабораторна робота №5<br>ПРОГРАМИ ЛІНІЙНОЇ СТРУКТУРИ</h1>
<h2 align="right">Виконав студент групи АН-12<br>Цімарний Єгор</h2>

## 1 Мета
<p align="justify">
&emsp;&emsp;<span style="font-size: 18px">Оволодіння практичними навиками розробки і
програмування обчислювального процесу лінійної структури і навиками по
відладці програм.</span>
</p>

## 2 Вихідні дані
<p align="center">
    <img src="./Знімок екрана 2026-10-06 122258.png" alt="Вихідні дані" style="width: 100%">
</p>

## 3 Отримані результати
<h3 align="center">Метод №1</h1>

<span style="font-size: 18px">**Скрипт**</span>
```m
clc
x=inputdlg({'Rebro kuba a =', 'Obyem kuba V =', 'Plosha bichnoi poverhni S ='}, 'Variant N16', 1);
a=str2double(x(1));
V=a^3;
S=6*a^2;
a=num2str(a);
V=num2str(V);
S=num2str(S);
x=inputdlg({'Rebro kuba a =', 'Obyem kuba V =', 'Plosha bichnoi poverhni S ='}, 'Variant N16', 1, {a, V, S});
```
<span style="font-size: 18px">**Результат виконання**</span>
<p align="center">
    <img src="./Знімок екрана 2026-10-06 123142.png" alt="Результат виконання" style="width: 35%">
</p>

<h3 align="center">Метод №2</h1>

<span style="font-size: 18px">**Скрипт**</span>
```m
clc
a = input('Vvedit rebro cuba a: ');
V = a ^ 3;
S = 6 * a ^ 2;
printf('Obyem kuba V = %g\nPlosha bichnoi poverhni S = %g\n', V, S);
```
<span style="font-size: 18px">**Результат виконання**</span>
```m
octave:16> Lab5_2
Vvedit rebro cuba a: 3.87
Obyem kuba V = 57.9606
Plosha bichnoi poverhni S = 89.8614
octave:17> diary off
```

## 4 Висновок
<p align="justify">
&emsp;&emsp;<span style="font-size: 18px">Під час виконання лабораторної роботи я оволодів практичними навиками розробки і
програмування обчислювального процесу лінійної структури і навичками по відладці програм. В даній лабораторній роботі я вперше скористався функцією "inputdlg()" котра використовується для вводу та виводу значень. Найдивнішим для мене було те, що значення введені у "inputdlg()" розцінюються системою як символьні і для подальшого застосування потребують функції "str2double()" (що переводить значення в числове), а для виведення результату необхідно дані перевести назад в символьне занчення через "num2str()". Було б добре якби була можливість попередньо вказати тип данних, що потраплять в "inputdlg()".
</span>
</p>