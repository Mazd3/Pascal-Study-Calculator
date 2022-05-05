unit Groups;

    Interface

uses crt;
Type PtrVertic=^StackVertic;
     StackVertic = record
     Number:Integer;
     Name : String[20];
     Next: PtrVertic;
    end;
    
    PtrHoriz=^StackHoriz;
    StackHoriz = record
    Number : integer;
    Group : string[10];
    Head : PtrVertic;
    Next : PtrHoriz;
   end;
   
Var Horiz: PtrHoriz;   
   
Procedure MakeMenuHoriz;
Procedure MakeMenuVertic(Var Vertic: PtrVertic);
Procedure ChoiceMenuHoriz;
Procedure PutMenuVertic(Vertic:PtrVertic; n:integer);
Procedure MenuGroup;

    Implementation


Procedure MakeMenuVertic(Var Vertic: PtrVertic);
Var Top: PtrVertic; Ok: boolean; NameValue: string[20]; k: integer;
begin
   Ok:= True;
   Vertic:= Nil;
   k:= 0;
   While Ok do
   Begin
    Writeln('Введите Фамилию студента');
     Readln(NameValue);
     k:= k+1;
     if (NameValue='n') or (NameValue='N') or (NameValue='т') or (NameValue='Т') then Ok:=False
      else
      begin
        New(Top);
        Top^.Next:=Vertic;
        Top^.Number:= k;
        Top^.Name := NameValue;
        Vertic:=Top;
      end;
    end;
end;

Procedure MakeMenuHoriz;
Var Vertic:PtrVertic; Top:PtrHoriz; GroupValue:string[10]; Ok:Boolean; k:integer;
Begin
 Ok:=True;
 Horiz:= Nil;
 k:=0;
 While Ok do
   Begin
     Writeln('Введите название группы');
     Readln(GroupValue);
     k:=k+1;
     if (GroupValue='n') or (GroupValue='N') or (GroupValue='Т') or (GroupValue='т') then Ok:= False
     else
       begin
        New(Top);
        Top^.Next:= Horiz;
        Top^.Number := k;
        Top^.Group := GroupValue;
        MakeMenuVertic(Vertic);
        Top^.Head:= Vertic;
        Horiz:=Top;
       end;
   end;
end;
     
     
     
Procedure PutMenuVertic(Vertic: PtrVertic; n:integer);
Var Top:PtrVertic; PozX, PozY: integer;
begin
 Top:= Vertic;
 PozY:=2;
 PozX:=12*n-7;
 While Top<>Nil do
  begin
   PozY:= PozY+1;
   GoToXY(PozX,PozY);
   Writeln(Top^.Name);
   Top:=Top^.Next;
  end;
end;


       
Procedure ChoiceMenuHoriz;
Var Top: PtrHoriz; n,k: integer;
begin
  Top:= Horiz;
  n:= 0;
  While Top<>Nil do
   begin
    n:=n+1;
    write(n:5,'.',Top^.Group:6);
    Top:=Top^.Next;
   end;
  GoToXY(30,22); Writeln('Выберите пункт меню');
  GoToXY(39,23); readln(n);
  Top:=Horiz;
  k:=1+Horiz^.Number;
  while (Top^.Number+n<>k) do Top:=Top^.Next;
  PutMenuVertic(Top^.Head , n);
end;

Procedure Wait;
begin
  Repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;

Procedure MenuGroup;
Var Mode : integer; Ok: boolean;
begin
  Ok := True;
  While Ok do
    begin
    ClrScr;
      Writeln('Выберите команду:');
      Writeln('  1.Создать группу');
      Writeln('  2.Посмотреть группу');
      Writeln('  0.Выход');
    Readln(Mode);
    ClrScr;
    case Mode of
      1:begin 
          MakeMenuHoriz;
          wait;
        end;
        
      2:begin
          ChoiceMenuHoriz;
          Wait;
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