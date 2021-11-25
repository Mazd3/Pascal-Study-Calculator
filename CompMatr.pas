unit CompMatr;

    interface

uses
  CRT, Compl;

const
  nn = 2;

type
  Matrix = array[1..nn, 1..nn] of Complex;

procedure AddMatr(A, B: Matrix; var C: Matrix);
procedure MultMatr(A, B: Matrix; var C: Matrix);
procedure ProdMatr(a: real; B: Matrix; var C: Matrix);
procedure ZeroMatr(var A: Matrix);
procedure OneMatr(var A: Matrix);
function NormMatr(A: Matrix): real;
procedure ExpMatr(A: Matrix; var s: Matrix);
procedure InputMatr(x, y: integer; var A: Matrix);
procedure OutputMatr(x, y: integer; A: Matrix);
procedure MenuCompMatr;

    implementation

procedure AddMatr(a, b: Matrix; var c: Matrix);
var
  i, j: integer;
begin
  for i := 1 to nn do
    for j := 1 to nn do
      Add(a[i, j], b[i, j], c[i, j]);
end;

procedure MultMatr(a, b: Matrix; var C: Matrix);
var
  i, j, k: integer; p, s: Complex;
begin
  for i := 1 to nn do
    for j := 1 to nn do
    begin
      Zero(s);
      for k := 1 to nn do
      begin
        Mult(a[i, k], b[k, j], p);
        Add(s, p, s);
      end;
      c[i, j] := s;
    end;
end;

procedure ProdMatr(a: real; b: Matrix; var c: Matrix);
var
  i, j: integer;
begin
  for i := 1 to nn do
    for j := 1 to nn do
      Prod(a, b[i, j], c[i, j]);
end;

procedure ZeroMatr(var A: Matrix);
var
  i, j: integer;
begin
  for i := 1 to nn do
    for j := 1 to nn do 
      Zero(A[i, j])
end;

procedure OneMatr(var A: Matrix);
var
  k: integer;
begin
  ZeroMatr(A);
  for k := 1 to nn do One(A[k, k])
end;

function NormMatr(A: Matrix): real;
var
  i, j: integer; s, z: real;
begin
  z := 0;
  for i := 1 to nn do
  begin
    s := 0;
    for j := 1 to nn do s := s + Modul(A[i, j]);
    if (s > z) then z := s;
  end;
  NormMatr := z;
end;

procedure ExpMatr(A: Matrix; var s: Matrix);
var
  k: integer; p: Matrix;
begin
  k := 0; OneMatr(p); s := p;
  while (NormMatr(p) >= eps) do
  begin
    k := k + 1;
    MultMatr(p, A, p);
    ProdMatr(1 / k, p, p);
    AddMatr(s, p, s);
  end;
end;

procedure InputMatr(x, y: integer; var A: Matrix);
var
  i, j: integer;
begin
  for i := 1 to nn do
    for j := 1 to nn do
    begin
      GoToXY(i * x + 9, j * y + 2);
      write('( ');
      read(A[i, j].Re);
      GoToXY(i * x + 14, j * y + 2);
      write(', ');
      read(A[i, j].Im);
      GoToXY(i * x + 18, j * y + 2);
      writeln(')');
    end;
  ClrScr;
end;

procedure OutputMatr(x, y: integer; A: Matrix);
var
  i, j: integer;
begin
  for i := 1 to nn do
    for j := 1 to nn do
    begin
      GoToXY(x + 10 * i, y + 2 * j);
      write('(', A[i, j].Re, ', ', A[i, j].Im, ')');
    end;
end;

procedure Wait;
begin
  repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

procedure MenuCompMatr;
var
  Mode: integer; Ok: boolean; f, w: real; A, B, C: Matrix;
begin
  Ok := true;
  while (Ok) do
  begin
    clrscr;
    writeln('Выберите операцию:');
    writeln('  1:Сумма матриц');
    writeln('  2:Умножение матриц');
    writeln('  3:Умножение матрицы на число');
    writeln('  4:Нулевая матрица');
    writeln('  5:Единичная матрица');
    writeln('  6:Нормаль матрицы');
    writeln('  7:Экспонента');
    writeln('  0:Вернуться');
    GoToXY(2, 22);
    readln(Mode);
    ClrScr;
    
    case Mode of
      1: 
        begin
          InputMatr(10, 3, A);
          InputMatr(10, 3, B);
          AddMatr(A, B, C);
          OutputMatr(10, 10, C);
          Wait;
        end;
      2: 
        begin
          InputMatr(10, 3, A);
          InputMatr(10, 3, B);
          MultMatr(A, B, C);
          OutputMatr(10, 10, C);
          Wait;
        end;
      3: 
        begin
          readln(f);
          InputMatr(10, 3, B);
          ProdMatr(f, B, C);
          OutputMatr(10, 10, C);
          Wait;
        end;
      4: 
        begin
          ZeroMatr(A);
          OutputMatr(10, 10, A);
          Wait;
        end;
      5: 
        begin
          OneMatr(A);
          OutputMatr(10, 10, A);
          Wait;
        end;
      6: 
        begin
          InputMatr(10, 3, A);
          w := NormMatr(A);
          writeln(w);
          Wait;
        end;
      7: 
        begin
          InputMatr(10, 3, A);
          ExpMatr(A, C);
          OutputMatr(20, 10, C);
          Wait;
        end;
      0: Ok := false
    else
      begin
        GoToXY(30, 21);
        writeln('Повторите ввод...');
        Wait;
      end;
    end;
  end;
end;
end.