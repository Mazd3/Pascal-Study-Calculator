Unit Stacks;

  Interface
  
uses crt;
Type Ptr=^Steck;  
     Steck=record
     Inf: integer;
     Next: Ptr;  
     end;
Type PtrQ = ^Turn;
     Turn = record
         Inf:integer;
         Next:PtrQ;
     end;
     
Var Top,Kon,Top1,Top2: Ptr;
    Value: integer;
    Tmpl,Tmpr:PtrQ;

Procedure MakeStack(Var Top:Ptr);
Procedure ViewStack(Var Top:Ptr);
Procedure AddStack(Var Top:Ptr);
Procedure AddStackAuto(Var Top:Ptr;x:integer);
Procedure ReverseStack(Var Top: Ptr);
Procedure ConcatStack(Var Top1, Top2: Ptr);
Procedure Headshot(Var Top:Ptr);
Procedure Delete(Var Top:Ptr);
Procedure StackQueue(Tur:Ptr; Var Left,Right:PtrQ);
Procedure ViewTurn(Left:PtrQ);
Procedure Wait;
Procedure MenuStack;

  Implementation

Procedure MenuStack;
Var Mode:integer;
     Ok:boolean;
begin
 Ok:=True;
 while Ok do
  begin
   ClrScr;
   writeln('Выберите пункт');
   writeln('  1. Ввести стек');
   writeln('  2. Добавить элементы к стеку');
   writeln('  3. Ввести второй стек и присоединить к первому');
   writeln('  4. Перевернуть стек');
   writeln('  5. Удалить верхушку стека');
   writeln('  6. Удалить стек');
   writeln('  7. Перевод из стека в очередь');
   writeln('  8. Просмотр стека');
   writeln('  0. Вернуться');
   readln(Mode);
    case Mode of
     1:begin ClrScr; MakeStack(Top1); ClrScr; ViewStack(Top1); Wait end;
     2:begin ClrScr; AddStack(Top1); ClrScr; ViewStack(Top1); Wait end;
     3:begin ClrScr; MakeStack(Top2); ConcatStack(Top2,Top1); Top1:=Top2; ClrScr; ViewStack(Top1); Wait end;
     4:begin ClrScr; ReverseStack(Top1); ViewStack(Top1); Wait end;
     5:begin ClrScr; Delete(Top1); ViewStack(Top1); Wait end;
     6:begin ClrScr; Headshot(Top1); ViewStack(Top1); Wait end;
     7:begin ClrScr; StackQueue(Top1, Tmpl, Tmpr); gotoxy(32,5); write('Изменено!'); ViewTurn(Tmpr); Wait end;
     8:begin ClrScr; ViewStack(Top1); Wait end;
     0:begin
        exit;
       end;
       else
       begin
        writeln('Пункт ',Mode,' отсутствует');
        Wait; 
       end;
     end; 
  end;
end;
    
Procedure Wait;
 begin
  repeat
  until KeyPressed;
  while KeyPressed do
  Readkey;
 end;
 
Procedure MakeStack(Var Top: Ptr);
Var Ok:boolean;
begin
 Ok:=True; Top:=Nil;
 writeln('Введите стэк("0" для остановки ввода)');
 while Ok do
 begin
  readln(Value);
  if Value=0 then Ok:=False
  else
  begin
   New(Kon);
   Kon^.Next:=Top;
   Kon^.Inf:=Value;
   Top:=Kon;
  end;
 end;
end;


Procedure ViewStack(Var Top:Ptr);
begin
 Kon:=Top;
 writeln('Вывод');
 while Kon<>Nil do
 begin
  writeln(Kon^.Inf);
  Kon:=Kon^.Next;
 end;
end;

Procedure AddStack(Var Top:Ptr);
Var Ok: boolean;
begin
 Ok:=True;
 writeln('Вводите новые элементы("0" для остановки ввода)');
 while Ok do
 begin
  readln(Value);
  if Value=0 then Ok:=False
  else
  begin
   New(Kon);
   Kon^.Next:=Top;
   Kon^.Inf:=Value;
   Top:=Kon;
  end;
 end;
end;

Procedure AddStackAuto(Var Top:Ptr;x:integer);
  begin
   Value := x;
   New(Kon);
   Kon^.Next:=Top;
   Kon^.Inf:=Value;
   Top:=Kon;
  end;

Procedure ConcatStack(Var Top1, Top2: Ptr); //цепка
Var P: Ptr;
begin
 P:=Top1; 
 while P^.Next<>Nil do
  P:=P^.Next;
 P^.Next := Top2;
end;

Procedure ReverseStack(Var Top: Ptr);
Var N,P:Ptr;
begin
 P:=Nil;
 while Top<>Nil do
 begin
  N:=Top^.Next;
  Top^.Next:=P;
  P:=Top;
  Top:=N;
 end;
 Top:=P;
end;

Procedure Headshot(Var Top:Ptr);
begin
 Top:=Nil;
end;

Procedure Delete(Var Top:Ptr);
begin
 Top:=Top^.Next;
end;

Procedure StackQueue(Tur:Ptr; Var Left,Right:PtrQ);
Var Kon:Ptr; Top:PtrQ;
begin
  Kon:=Tur; New(Top);
  Top^.Inf:=Kon^.Inf;
  Right:=Top; Left:=Top;
  Kon:=Kon^.Next;
  while Kon<>Nil do begin
    New(Top); Right^.Next:=Top;
    Top^.Inf:=Kon^.Inf; Right:=Top;
    Kon:=Kon^.Next
  end;
  Top^.Next:=Nil
end;

Procedure ViewTurn(Left:PtrQ);
  Var Top:PtrQ;
  begin
    Top:=Left;
    while Top <> Nil do begin
      writeln(Top^.Inf);
      Top:=Top^.Next
    end
  end;
end.