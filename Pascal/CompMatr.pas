unit CompMatr;

     interface
     
uses crt, Compl;
const n = 2;
type Matrix = array[1..n, 1..n] of Complex;   
  procedure MenuCompMatr;
  procedure InputMatrix(x, y: integer; var A: Matrix);{ввод}
  procedure OutputMatrix(x, y: integer; A: Matrix);{вывод}
  procedure AddMatrixA, B: Matrix; var C: Matrix);{сложение}(
  procedure MultMatrix(A, B: Matrix; var C: Matrix);{умножение}
  procedure ProdMatrix(a: real; B: Matrix; var C: Matrix);{деление}
  procedure ZeroMatrix(var A: Matrix);{нуль}
  procedure OneMatrix(var A: Matrix);{единица}
  function NormMatrix(A: Matrix):real;{нормаль матрицы}

     implementation

 procedure InputMatrix(x, y: integer; var A: Matrix);
     var i, j: integer;
     begin
      for i:=1 to n do
        for j:=1 to n do
          begin
            GoToXY(i*x+9, j*y+2);
            write('(');
            read(A[i,j].Re);
            GoToXY(i*x+11,j*y+2);
            write(', ');
            read(A[i,j].Im);
            GoToXY(i*x+14,j*y+2);
            writeln(')');
          end;
          clrscr;
     end;

  procedure OutputMatrix(x,y:integer; A:Matrix);
     var i,j:integer;
     begin
          for i:=1 to n do
            for j:=1 to n do
              begin
                GoToXY(x+8*i,y+2*j);
                write('(',A[i,j].Re,', ',A[i,j].Im,')');
              end;
     end;
  procedure AddMatrix(A,B:Matrix; var C:Matrix);
    var i,j:integer;
     begin
          for i:=1 to n do
            for j:=1 to n do
              Add(A[i,j],B[i,j],C[i,j]);
     end;

  procedure MultMatrix(A,B:Matrix; var C:Matrix);
     var i,j,k:integer; p,s:Complex;
     begin
          for i:=1 to n do
              for j:=1 to n do
              begin
                   Zero(s);
                   for k:=1 to n do
                   begin
                        Mult(A[i,k],B[k,j],p);
                        Add(s,p,s);
                   end;
                   C[i,j] := s;
              end;
     end;

  procedure ProdMatrix(a:real; B:Matrix; var C:Matrix);
     var i,j:integer;
     begin
          for i:=1 to n do
              for j:=1 to n do
                  Prod(a,B[i,j],C[i,j]);
     end;

  procedure ZeroMatrix(var A:Matrix);
     var i,j:integer;
     begin
          for i:=1 to n do
              for j:=1 to n do Zero(A[i,j])
     end;

  procedure OneMatrix(var A:Matrix);
     var k:integer;
     begin
          ZeroMatrix(A);
          for k:=1 to n do One(A[k,k])
     end;

  function NormMatrix(A:Matrix):real;
     var i,j:integer; s,z:real;
     begin
          z := 0;
          for i:=1 to n do
          begin
               s := 0;
               for j:=1 to n do s := s + Modul(A[i,j]);
               if (s > z) then z := s;
          end;
          NormMatrix := z;
     end;
     
  procedure Wait;
     Var ch: char;
     begin
          repeat until KeyPressed;
          while KeyPressed do ch:= ReadKey;
     end;
     
  procedure MenuCompMatr;
     var Mode:integer; Ok:boolean; f,w:real; A,B,C:Matrix;
     begin
     Ok:=true;
     while (Ok) do
     begin
     clrscr;
     writeln('Укажите режим');
     writeln('1: Сложение');
     writeln('2: Умножение');
     writeln('3: Умножение на число');
     writeln('4: Нуль');
     writeln('5: Единицы');
     writeln('6: Норма матрица');
     writeln('0: Выход');
     GoToXY(40,23); readln(Mode);
     clrscr;
     
     case Mode of
     1: begin
          InputMatrix(10,10,A);
          InputMatrix(10,10,B);
          AddMatrix(A,B,C);
          OutputMatrix(20,20,C);
          Wait;
        end;
     2: begin
          InputMatrix(10,10,A);
          InputMatrix(10,10,B);
          MultMatrix(A,B,C);
          OutputMatrix(20,20,C);
          Wait;
        end;
     3: begin
          readln(f);
          InputMatrix(10,10,B);
          ProdMatrix(f,B,C);
          OutputMatrix(20,20,C);
          Wait;
        end;
     4: begin
          InputMatrix(10,10,A);
          ZeroMatrix(A);
          OutputMatrix(20,20,A);
          Wait;
        end;
     5: begin
          InputMatrix(10,10,A);
          OneMatrix(A);
          OutputMatrix(20,20,A);
          Wait;
        end;
     6: begin
          InputMatrix(10,10,A);
          w := NormMatrix(A);
          writeln(w);
          Wait;
        end;
     0: Ok:=false
     else
     begin
          GoToXY(30,27);
          writeln('Ошибка! Повторите ввод');
          Wait;
     end;
     end;
     end;
     end;
end.

