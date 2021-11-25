uses crt,Compl,CompMatr,RealVect,CompVect;
Var Mode : integer; Ok: boolean;
begin
  Ok:= True;
  While Ok do
      begin
        ClrScr;
        Writeln('Выберите раздел:');
        writeln(' 1.Комплексные числа');
        writeln(' 2.Комплексные матрицы');
        writeln(' 3.Вещественные вектора');
        writeln(' 4.Комплексные вектора'); 
        Writeln(' 0.Выход');
        GoToXY(40,23);
        Readln(Mode);
        GoToXY(1,1); ClrScr;
      Case Mode of
        1: MenuComplex;
        2: MenuCompMatr;
        3: MenuRealVect;
        4: MenuCompVect;
        0: Ok:=False;
      else
        begin
          GoToXY(30,20);
          Writeln('Повторите ввод!');
          delay (900);
        end
      end
   end
End.