Unit Compl;

    interface
    
uses crt;
const eps = 0.0001;
type Complex = record re, im: real end;
  procedure MenuComplex;
  procedure Input(u, v: integer; var w: Complex);{ввод}
  procedure Output(u, v: integer; var w: Complex);{вывод}
  procedure Add(u, v: Complex; var w: Complex);{сложение}
  procedure Mult(u, v: Complex; var w: Complex);{умножение}
  procedure Inv(z: Complex; var w: Complex);{инверсия}
  procedure Division(v, u: Complex; var w: Complex);{деление}  
  procedure Con(z: Complex; var w: Complex);{сопряжение}
  procedure Prod(a: real; z: Complex; var w: Complex);{умножение на число}
  procedure Zero(var w: Complex);{нуль}
  procedure One(var w: Complex);{один}
  procedure ExpC(z: Complex; var w: Complex);{комп эксп}
  procedure CosC(z: Complex; var w: Complex);{комп кос}
  procedure SinC(z: Complex; var w: Complex);{комп син}
  procedure LnC(z: Complex; var w: Complex);{комп лог}
  function Modul(z: Complex): real;{модуль}

  
    implementation
    
   procedure Wait;
     Var ch: char;
     begin
          repeat until KeyPressed;
          while KeyPressed do ch:= ReadKey;
     end;

  procedure Input(u,v:integer; var w:Complex);
    begin
      GoToXY(u,v); read(w.Re); 
      GoToXY(u+7,v); read(w.Im);
      GoToXY(u,v);
      writeln('(',w.Re,')+i*(',w.Im,')');
    end;

  procedure Output(u,v: integer; var w:Complex);
    begin
      GoToXY(u,v);
      write('(',w.Re,')+i*(',w.Im,')');
    end;
     
  procedure Add(u, v: Complex; var w: complex);
    begin
      w.Re := u.Re + v.Re;
      w.Im := u.Im + v.Im;
    end;
    
  procedure Mult(u, v: Complex; var w: complex);
    begin
      w.Re := u.Re*v.Re - u.Im*v.Im;
      w.Im := u.Re*v.Im + u.Im*v.Re;
    end;
    
  procedure Inv(z: Complex; var w: complex);
    var znam: real;
    begin
      znam := sqr(z.Re) + sqr(z.Im);
      w.Re := z.Re/znam;
      w.Im := -z.Im/znam;
    end;
    
  procedure Division(v, u: Complex; var w: complex);
    Var z: complex;
    begin
      Inv(v,z); 
      Mult(u,z,w);
    end;

  procedure Con(z: complex; var w: complex);
    begin
      w.Re := z.Re;
      w.Im := -z.Re;
    end;

  procedure Prod(a: real; z: complex; var w: complex);
    begin
      w.Re := a*z.Re;
      w.Im := a*z.Im;
    end;    

  procedure Zero(var w: complex);
    begin
      w.Re := 0;
      w.Im := 0;
    end;  

 procedure One(var w: Complex);
    begin
      w.Re := 1;
      w.Im := 0;
    end;    

  function Modul(z: complex): real;
    begin
      Modul := sqrt(sqr(z.Re) + sqr(z.Im));
    end;
    
  procedure ExpC(z: Complex; var w: Complex);
     var p: Complex;
         k: integer;
     begin
          One(p);
          One(w);
          k:=0;
          while (Modul(p) >= eps) do
          begin
               k:=k + 1;
               Mult(p, z, p);
               Prod(1/k, p, p);
               Add(w, p, w);
          end;
  end;

  procedure CosC(z: Complex; var w: Complex); 
     var p,z2: Complex;
         k: integer;
     begin
          k:=0;
          One(w);
          One(p);
          Mult(z, z, z2);
          while (Modul(p) >= eps) do
          begin
               k:=k + 2;
               Mult(p, z2, p);
               Prod(-1/ k/(k-1), p, p);
               Add(w, p, w);
          end;
      end;

  procedure SinC(z: Complex; var w: Complex);
     var p,z2: Complex;
         k: integer;
     begin
          k:=0;
          P:=z;
          w:=z;
          Mult(z, z, z2);
          while (Modul(p) >= eps) do
          begin
               k:=k+2;
               Mult(p, z2, p);
               Prod(-1/ k/(k+1), p, p);
               Add(w, p, w);
          end;
     end;

  procedure LnC(z: Complex; var w: Complex);
     var p, q: Complex;
         k: integer;
     begin
          k:=1;
          p:=z;
          w:=z;
          while (Modul(p) >= k*eps) do
          begin
               k:=k + 1;
               Mult(p, z, p);
			         Prod(-1/k, p, q);
               Add(w, q, w);
          end;
     end;
     
  procedure MenuComplex;
  var mode: integer; ok: boolean; u,v,w: complex; f,q:real; 
  begin
    ok:= true;
    while ok do
    begin
      clrscr;
      writeln('Укажите режим');
      writeln('1: Сложение');
      writeln('2: Умножение');
      writeln('3: Перевернуть');
      writeln('4: Деление');
      writeln('5: Сопряжение');
      writeln('6: Умножение на число');
      writeln('7: Ноль');
      writeln('8: Один');
      writeln('9: Модуль');
      writeln('10: Экспонента');
      writeln('11: Косинус');
      writeln('12: Синус');
      writeln('13: Логарифм');
      writeln('0: Выход');
     gotoxy(30,21); readln (mode);
     gotoxy(30,21); writeln('    ');
     clrscr;
     case mode of
          1: begin
              Input(0,1,u);
              Input(0,3,v);
              Add(u,v,w);
              Output(35,2,w);
              Wait;
             end;
          2: begin
              Input(20,20,u);
              Input(30,20,v);
              Mult(u,v,w);
              Output(40,20,w);
              Wait;
            end;
         3: begin
              Input(20,20,u);
              Inv(u,w);
              Output(30,20,w);
              Wait;
            end;
         4: begin
              Input(20,20,u);
              Input(30,20,v);
              Division(u,v,w);
              Output(40,20,w);
              Wait; 
            end;
         5: begin
              Input(20,20,u);
              Con(u,w);
              Output(30,20,w);
              Wait;
            end;
         6: begin
              readln(f);
              Input(20,20,u);
              Prod(f,u,w);
              Output(30,20,w);
              Wait;
            end;
         7: begin
              Input(20,20,u);
              Zero(u);
              Output(30,20,u);
              Wait;
            end;
         8: begin
              Input(20,20,u);
              One(u);
              Output(30,20,u);
              Wait;
            end;
         9: begin
              Input(20,20,u);
              q := Modul(u);
              writeln(q);
              Wait;
            end;
         10: begin
               Input(20,20,u);
               ExpC(u,w);
               Output(30,20,w);
               Wait;
             end;
         11: begin
               Input(20,20,u);
               CosC(u,w);
               Output(30,20,w);
               Wait;
             end;
         12: begin
               Input(20,20,u);
               SinC(u,w);
               Output(30,20,w);
               Wait;
             end;
         13: begin
               Input(20,20,u);
               LnC(u,w);
               Output(30,20,w);
               Wait;
             end;
         0: Ok:=false
      else
             begin
                  GoToXY(30,27);
                  writeln('Ошибка! Повторите ввод');
                  Wait;
             end;
         end
     end
     end;
 end.
  
