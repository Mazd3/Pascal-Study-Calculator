unit Trees; 
     Interface
     uses crt;
Type NodePtr=^Node;
     Node=record
      Name:char;
      left,right:NodePtr;
     end;
     
Type Note = record
    Ch:char;
    Left,Right:byte
  end;

Const n = 11;
var key,symbol:char;
    Ok:boolean;
    Glvl:byte;
    leaf:NodePtr;
    Tree:array[1..n] of Note;
    NTree:string[12];
    FTree: file of Note;
  
procedure MenuTree;
procedure MakeTree(var Top:NodePtr);
procedure ViewTree;
procedure WayUpDown(Next:byte);
procedure WayDownUp(Next:byte);
procedure WayHoriz(Next,Level:byte);
procedure AddSubTree(Top:NodePtr);

Implementation

procedure Wait;
begin
  repeat
  until KeyPressed;
  while KeyPressed do
  ReadKey
end;

procedure MenuTree;
var Mode:integer;
    ok:boolean;
    NewTree:NodePtr;
    i:integer;
begin
 Ok:=true;
 while Ok do 
 begin
  ClrScr;
  writeln(' Выберите пункт');
  writeln(' 1: Создать дерево');
  writeln(' 2: Просмотр сверху вниз');
  writeln(' 3: Просмотр снизу вверх');
  writeln(' 4: Поуровневый просмотр');
  writeln(' 5: Добавление поддерева');
  writeln(' 6: Просмотр дерева');  
  writeln(' 0: Назад');
  readln(Mode); ClrScr;
  case Mode of 
   1:begin
      MakeTree(NewTree);
      ClrScr;
     end;
   2:begin
      Clrscr;
      GoToXY(30,1); write('Просмотр древа:');
      GoToXY(30,2); readln(NTree);
      assign(FTree, NTree);
      if FileExists(NTree) then 
      begin
        reset(FTree);
        for i:=1 to n do
          read(FTree, Tree[i]);
          WayUpDown(1);
          close(FTree)
      end
      else
        write('Файл ',NTree,' не найден!');
        Wait
      end;
   3:begin
      Clrscr;
      GoToXY(30,1); write('Просмотр древа:');
      GoToXY(30,2); readln(NTree);
      assign(FTree, NTree);
      if FileExists(NTree) then 
      begin
      reset(FTree); 
      for i:=1 to n do
       read(FTree, Tree[i]);
       WayDownUp(1);
       close(FTree)
      end
      else
        write('Файл ',NTree,' не найден!');
        Wait
    end;
   4:begin
     Clrscr;
     GoToXY(30,1); write('Введите дерево:');
     GoToXY(30,2); readln(NTree);
     assign(FTree, NTree);
     if FileExists(NTree) then 
     begin
       reset(FTree);
       Clrscr; GoToXY(25,3);
       write('Введите этаж:');
       GoToXY(39,3); readln(Glvl);
       for i:=1 to n do
       read(FTree, Tree[i]);
       WayHoriz(1,Glvl);
       close(FTree)
     end
       else
        write('Файл ',NTree,' не найден!');
        Wait
      end;
   5:begin
      AddSubTree(NewTree);
     end;
   6:begin
      ViewTree;
      wait
      end;
   0:begin
      Ok:=False; 
     end;
    end;
  end;
end;

procedure MakeTree;
  var k:integer;
  begin
    GoToXY(30,1); writeln('Дайте имя дереву');
    GoToXY(30,2); readln(NTree);
    assign(FTree, NTree);
    rewrite(FTree); ClrScr;
    for k:=1 to n do
      with Tree[k] do begin
        GoToXY(33,3); write(k);
        GoToXY(30,5); write('Символ:');
        GoToXY(38,5); readln(ch);
        GoToXY(30,7); write('Левый:');
        GoToXY(37,7); readln(Left);
        GoToXY(30,9); write('Правый:');
        GoToXY(38,9); readln(Right);
        Write(FTree, Tree[k]); ClrScr
      end;
    close(FTree)
end;

procedure ViewTree;
  var k:integer;
  begin
    GoToXY(30,1); write('Просмотр древа:');
    GoToXY(30,2); readln(NTree);
    assign(FTree, NTree);
    ClrScr; GoToXY(30,3); k:=1;
    if FileExists(NTree) then begin
      reset(FTree);
      while not EOF(FTree)do
        with Tree[k] do begin
          read(FTree, Tree[k]);
          GoToXY(30,k+1); write(k);
          GoToXY(35,k+1); write(ch);
          GoToXY(40,k+1); write(Left);
          GoToXY(45,k+1); write(Right);
          Inc(k)
        end;
        close(FTree)
    end
    else
      write('Файл ',NTree,' не найден!')
  end;
  
procedure WayUpDown(Next:byte);
begin
  if Next<>0 then
    with Tree[Next] do begin
      write(ch);
      WayUpDown(Left);
      WayUpDown(Right)
    end
end;

procedure WayDownUp(Next:byte);
begin
  if Next<>0 then
    with Tree[Next] do begin
      WayDownUp(Left);
      WayDownUp(Right);
      write(ch)
    end
end;

procedure WayHoriz(Next,Level:byte);
begin
  if Next<>0 then
    with Tree[Next] do
      if Level=1 then write(ch)
      else begin
        WayHoriz(Left,Level-1);
        WayHoriz(Right,Level-1)
      end
end;

procedure Search(Top:NodePtr;var Leaf:NodePtr);
begin
 if (Top<>Nil)and(Ok=true) then
 begin
  if Symbol=Top^.Name then
  begin
   Ok:=false; Leaf:=Top
  end
  else
  begin
   Search(Top^.Left,Leaf);
   Search(Top^.Right,Leaf);
  end
 end
end;

procedure AddSubTree(Top: NodePtr);
begin
 GoToXY(30, 14); writeln('Введите искомый узел: '); ClearLine;
 GoToXY(40, 15); readln(Symbol);  Gotoxy(1,15); ClearLine;
 Ok:=True; Search(Top,Leaf); 
 ClrScr;
 if Ok then
 begin
  write('Узел ',Symbol,' не найден ');
  wait;  
 end
 else
 begin
  GoToXY(1,20); ClearLine;
  GoToXY(23,20); writeln('Хотите построить левое поддерево у узла ',Leaf^.Name,' ?'); ClearLine;
  GoToXY(40,21); readln(Key); gotoxy(1,21); ClearLine;
  ClearLine;
  if Key  in ['y', 'Y', 'н', 'Н'] then
   if Leaf^.Left<>Nil then
   begin
    GoToXY(25,19); writeln('Левое поддерево у узла ',Leaf^.Name,' уже есть'); ClearLine;
    GoToXY(25,20); writeln('Все-таки хотите продолжить?'); ClearLine;
    GoToXY(40,21); readln(Key); gotoxy(1,21); ClearLine;
    GoToXY(1,19); ClearLine;
    GoToXY(1,20); ClearLine;
    if Key in ['y','Y','н','Н'] then
    begin
     MakeTree(Top); Leaf^.Left:=Top
    end
   end
   else
   begin
    MakeTree(Top); Leaf^.Left:=Top
   end;
   GoToXY(1,20); ClearLine;
   GoToXY(23,20); writeln('Хотите построить правое поддерево у узла ',Leaf^.Name,' ?'); ClearLine;
   GoToXY(40,21); readln(Key); gotoxy(1,21); ClearLine;
   if Key  in ['y','Y','н','Н'] then
    if Leaf^.Right<>Nil then
    begin
     GoToXY(25, 19); writeln('Правое поддерево у узла ', Leaf^.Name,' уже есть'); ClearLine;
     GoToXY(25, 20); writeln('Все-таки хотите продолжить?'); ClearLine;
     GoToXY(40, 21); readln(Key); gotoxy(1,21); ClearLine;
     if Key in ['y','Y','н','Н'] then
      begin
       MakeTree(Top); Leaf^.Right:=Top
      end
     end
     else
     begin
      MakeTree(Top); Leaf^.Right:=Top
     end
    end;
  end;
end.