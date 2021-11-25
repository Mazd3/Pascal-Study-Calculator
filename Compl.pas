unit Compl;

    interface

uses
  CRT;

const
  eps = 0.001;

type
  Complex = record
    Re, Im: real;
  end;

procedure Add(u, v: Complex; var w: Complex);
procedure Mult(u, v: Complex; var w: Complex);
procedure Inv(z: Complex; var w: Complex);
procedure Diviz(u, v: Complex; var w: Complex);
procedure Codj(z: Complex; var w: Complex);
procedure Prod(a: real; z: Complex; var w: Complex);
procedure Zero(var w: Complex);
procedure One(var w: Complex);
function Modul(z: Complex): real;
procedure ExpC(z: Complex; var w: Complex);
procedure CosC(z: Complex; var w: Complex);
procedure SinC(z: Complex; var w: Complex);
procedure Input(x, y: integer; var z: Complex);
procedure Output(x, y: integer; var z: Complex);
procedure MenuComplex;

    implementation

procedure Add(u, v: Complex; var w: Complex);
begin
  w.Re := u.Re + v.Re;
  w.Im := u.Im + v.Im;
end;

procedure Mult(u, v: Complex; var w: Complex);
begin
  w.Re := u.Re * v.Re - u.Im * v.Im;
  w.Im := u.Re * v.Im + v.Re * u.Im;
end;

procedure Inv(z: Complex; var w: Complex);
var
  znam: real;
begin
  znam := sqr(z.Re) + sqr(z.Im);
  w.Re := z.Re / znam;
  w.Im := -z.Im / znam;
end;

procedure Diviz(u, v: Complex; var w: Complex);
var
  z: Complex;
begin
  Inv(v, z);
  Mult(u, z, w);
end;

procedure Codj(z: Complex; var w: Complex);
begin
  w.Re := z.Re;
  w.Im := -z.Im;
end;

procedure Prod(a: real; z: Complex; var w: Complex);
begin
  w.Re := a * z.Re;
  w.Im := a * z.Im;
end;

procedure Zero(var w: Complex);
begin
  w.Re := 0;
  w.Im := 0;
end;

procedure One(var w: Complex);
begin
  w.Re := 1;
  w.Im := 0;
end;

function Modul(z: Complex): real;
begin
  Modul := sqrt(sqr(z.Re) + sqr(z.Im));
end;

procedure ExpC(z: Complex; var w: Complex);
var
  p: Complex;
  k: integer;
begin
  One(p); One(w); k := 0;
  while (Modul(p) >= eps) do
  begin
    k := k + 1;
    Mult(p, z, p);
    Prod(1 / k, p, p);
    Add(w, p, w);
  end;
end;

procedure CosC(z: Complex; var w: Complex);
var
  p, z2: Complex;
  k: integer;
begin
  k := 0; One(w); One(p); Mult(z, z, z2);
  while (Modul(p) >= eps) do
  begin
    k := k + 2;
    Mult(p, z2, p);
    Prod(-1 / k / (k - 1), p, p);
    Add(w, p, w);
  end;
end;

procedure SinC(z: Complex; var w: Complex);
var
  p, z2: Complex;
  k: integer;
begin
  k := 0; P := z; w := z; Mult(z, z, z2);
  while (Modul(p) >= eps) do
  begin
    k := k + 2;
    Mult(p, z2, p);
    Prod(-1 / k / (k + 1), p, p);
    Add(w, p, w);
  end;
end;

procedure Input(x, y: integer; var z: Complex);
begin
  GoToXY(x, y); readln(z.Re);
  GoToXY(x + 7, y); readln(z.Im);
  GoToXY(x, y);
  writeln('(', z.Re, ')+i*(', z.Im, ')');
end;

procedure Output(x, y: integer; var z: Complex);
begin
  GoToXY(x, y);
  writeln('(', z.Re, ')+i*(', z.Im, ')');
end;


procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do Readkey;
end;

procedure MenuComplex;
var
  Mode: integer; Ok: boolean; d, f: real; u, v, w: Complex;
begin
  Ok := true;
  while Ok = true do
  begin
    ClrScr;
    writeln('Выберите операцию:');
    writeln('  1:Сложение комплексных чисел');
    writeln('  2:Умножение комплексных чисел');
    writeln('  3:Обратное комплексное число');
    writeln('  4:Деление комплексных чисел');
    writeln('  5:Противоположное комплексное число');
    writeln('  6:Умножение комплексного числа на вещественное');
    writeln('  7:Комплексный ноль');
    writeln('  8:Комплексная единица');
    writeln('  9:Модуль комплексного числа');
    writeln('  10:Экспонента комплексного числа');
    writeln('  11:Косинус комплексного числа');
    writeln('  12:Синус комплексного числа');
    writeln('  0:Вернуться');
    GoToXY(2, 22);
    readln(Mode);
    ClrScr;
    
    case Mode of
      1: 
        begin
          Input(10, 10, u);
          Input(30, 10, v);
          Add(u, v, w);
          Output(50, 10, w);
          Wait;
        end;
      2: 
        begin
          Input(10, 10, u);
          Input(30, 10, v);
          Mult(u, v, w);
          Output(50, 10, w);
          Wait;
        end;
      3: 
        begin
          Input(10, 10, u);
          Inv(u, w);
          Output(30, 10, w);
          Wait;
        end;
      4: 
        begin
          Input(10, 10, u);
          Input(30, 10, v);
          Diviz(u, v, w);
          Output(50, 10, w);
          Wait;
        end;
      5: 
        begin
          Input(10, 10, u);
          Codj(u, w);
          Output(30, 10, w);
          Wait;
        end;
      6: 
        begin
          GoToXY(10, 10);
          readln(d);
          Input(30, 10, u);
          Prod(d, u, w);
          Output(50, 10, w);
          Wait;
        end;
      7: 
        begin
          Zero(u);
          Output(30, 10, u);
          Wait;
        end;
      8: 
        begin
          One(u);
          Output(30, 10, u);
          Wait;
        end;
      9: 
        begin
          Input(10, 10, u);
          f := Modul(u);
          GoToXY(30, 10);
          writeln(f);
          Wait;
        end;
      10: 
        begin
          Input(10, 10, u);
          ExpC(u, w);
          Output(30, 10, w);
          Wait;
        end;
      11: 
        begin
          Input(10, 10, u);
          CosC(u, w);
          Output(30, 10, w);
          Wait;
        end;
      12: 
        begin
          Input(10, 10, u);
          SinC(u, w);
          Output(30, 10, w);
          Wait;
        end;
      
      0: Ok := false;
    else
      begin
        GoToXY(30, 21);
        writeln('Повторите ввод...');
        delay(5000);
      end;
    end;
  end;
end;    
end.