unit Queues;

    Interface
    
uses crt;

Type PtrQ = ^Queu;
     Queu = record
     Inf: Integer;
     Next: PtrQ;
     end;
     
Var Left,Right: PtrQ;
     
Procedure MakeQueue;
Procedure DeleteQueue;
Procedure VievQueue;
Procedure Wait;
Procedure MenuQueue;

    Implementation

Procedure MakeQueue;
Var Ok:boolean; Value: integer; Top: PtrQ;
begin
  Ok:=true;
  Writeln('Введите число');
  Readln(Value);
  New(Top);
  if Value=999 then
    begin
      Ok:=false;
      Top^.Next:=Nil;
    end;
  Top^.Inf:=Value;
  Right:=Top;
  Left:=Top;
  While Ok do
    begin
      Writeln('Введите число');
      Readln(Value);
      if Value=999 then
        begin
        Ok:=False;
        Top^.Next:=Nil;
        end
      else
      begin
        New(Top);
        Right^.Next:=Top;
        Top^.Inf:=Value;
        Right:=Top;
      end;
    end;
end;
  
  
Procedure VievQueue;
begin
Right:=Left;
While (Right<>Nil) do
  begin
    Writeln(Right^.Inf);
    Right:=Right^.Next;
  end;
end;

Procedure DeleteQueue;
begin
  if (Left<>Nil) then
  Left:=Left^.Next;
end;

Procedure Wait;
begin
  Repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;   
   
Procedure MenuQueue;
Var Mode : integer; Ok: boolean;
begin
  Ok := True;
  While Ok do
    begin
    ClrScr;
      Writeln('Выберите команду:');
      Writeln('  1.Создать очередь');
      Writeln('  2.Посмотреть очередь');
      Writeln('  3.Удалить очередь');
      Writeln('  0.Назад');
    Readln(Mode);
    ClrScr;
    case Mode of
      1:begin 
          MakeQueue;
          wait;
        end;
        
      2:begin
          VievQueue;
          Wait;
        end;
        
      3:begin
          DeleteQueue;
        end;
        
      0: Ok:=False;
      else
        begin
        GoToXY(30,20);
        Writeln('Ошибка, повторите ввод!');
        delay (1000);
        ClrScr;
        end
      end;
     end;
   end;
End.