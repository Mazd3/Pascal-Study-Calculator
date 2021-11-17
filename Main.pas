program Calculator;
Uses crt, Compl, CompMatr;
var mode: integer; ok: boolean;

procedure Wait;
var ch: char;
begin
   repeat until KeyPressed;
   while KeyPressed do ch:=ReadKey;
end;

begin
  ok:= true;
  while ok do
  begin
    clrScr;
    writeln('Выберите пункт');
    writeln('1: Комплексные числа');
    writeln('2: Комплексные матрицы');
    writeln('0: Выход');
      gotoxy(40,23); readln(mode);
      gotoxy(40,23); writeln('          ');
    case mode of
      1: MenuComplex;
      2: MenuCompMatr;
      0: ok := false;
    else
      begin 
        gotoxy(30,21); writeln ('Ошибка! Повторите ввод');
        wait;
      end;
    end;
  end;
end.