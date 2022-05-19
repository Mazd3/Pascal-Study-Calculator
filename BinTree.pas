Unit BinTree; 
Interface
Uses Crt;  
Type NodePtr = ^Node;
     Node = record
     Key: byte;
     Left, Right: NodePtr;
     end;

Var Top,Root:NodePtr; Level:byte;

Procedure MakeNode(NewKey:byte;Var Top:NodePtr);
Procedure MakeBTree(Var Top:NodePtr);
Procedure BUpDown(Top:NodePtr);
Procedure BDownUp(Top:NodePtr);
Function BHigh(Top:NodePtr):byte;
Procedure BHoriz(Top:NodePtr;level:byte);
Procedure ViewBTree(Top:NodePtr);
Procedure BeautifulViewBT(Top:NodePtr; x,y:byte);
Function SearchNode(Top:NodePtr;SearchKey:byte):NodePtr;
Procedure DeleteSubTree(Top:NodePtr);
Procedure MenuBinTree;

Implementation
Procedure Wait;
  begin
    repeat until Keypressed;
    while Keypressed do readKey;
  end;
   
Procedure MenuBinTree;
  Var ok:boolean; mode:integer; x,y:byte;
  Begin
    ok:=True;
    while ok do
    begin
      Clrscr;
      writeln(' Выберите пункт');
      writeln(' 1: Создание дерева');
      writeln(' 2: Просмотр дерева');
      writeln(' 3: Красивый просмотр дерева');
      writeln(' 4: Обход сверху-вниз');
      writeln(' 5: Обход снизу-вверх');
      writeln(' 6: Просмотр этажа');
      writeln(' 7: Удаление');
      writeln(' 0: Назад');
      readln(mode);
        case mode of
        1:begin
            Clrscr; 
            MakeBTree(Root); 
            Wait
        end;
        2:begin
            Clrscr; 
            ViewBTree(Root);
            Wait
        end;
        3:begin
            Clrscr;
            y:=1; x:=30;
            BeautifulViewBT(Root,x,y);
            Wait
        end;
        4:begin
            Clrscr;
            BUpDown(Root);
            Wait
        end;
        5:begin
            Clrscr;
            BDownUp(Root);
            Wait
        end;
        6:begin
            Clrscr; 
            GoToXY(30,5);
            writeln('Введите этаж:');
            GoToXY(43,5); 
            readln(Level);
            BHoriz(Root,Level);
            Wait
        end;
        7:begin
            Clrscr; 
            DeleteSubTree(Root); 
            Wait
          end;
        0:ok:=False;
        else
        begin
          GoToXY(30,21);
          writeln('Ошибка!Повторите Ввод');
          Wait
        end
      end
    end
  end;
  
  
Procedure MakeNode(NewKey:byte; Var Top:NodePtr);
  begin
    if Top = Nil then begin
      New(Top); Top^.Key:=NewKey;
      Top^.Left:=Nil; Top^.Right:=Nil;
    end
    else
      if NewKey < Top^.Key then
        MakeNode(NewKey, Top^.Left)
      else
        MakeNode(NewKey, Top^.Right);
  end;

Procedure MakeBTree (Var Top:NodePtr);
  Var i,n,InputKey:byte; Ky:char;
  begin
    GoToXY(30,2); writeln('Авто ввод? (Y/N)');
    GoToXY(35,3); readln(Ky); ClrScr;
    if Ky in['y','Y','н','Н']then begin
      GoToXY(30,2); writeln('Количество ветвей:');
      GoToXY(48,2); readln(n); ClrScr; Top:=Nil;
      for i:=1 to n do begin
        InputKey:=random(2*n);
        MakeNode(InputKey, Top);
      end
    end
    else begin
      GoToXY(30,2); writeln('Количество ветвей:');
      GoToXY(48,2); readln(n); ClrScr; Top:=Nil;
      for i:=1 to n do begin
        GoToXY(30,2); writeln('Значение (',i,'/',n,') ветки:');
        GoToXY(51,2); readln(InputKey); ClrScr;
        MakeNode(InputKey, Top);
      end
    end
  end;

Procedure BUpDown(Top: NodePtr);
  begin
    if Top<> Nil then begin
      write(Top^.Key:4);
      BUpDown(Top^.Right);
      BUpDown(Top^.Left);
    end
  end;
  
Procedure BDownUp(Top: NodePtr);
  begin
    if Top<> Nil then begin
      BDownUp(Top^.Right);
      BDownUp(Top^.Left);
      write(Top^.Key:4);
    end
  end;
  
Function BHigh(Top: NodePtr):byte;
  Var HighLeft, HighRight:byte;
  begin
    if Top=Nil then BHigh:=0
    else begin
      HighLeft:=BHigh(Top^.left);
      HighRight:=BHigh(Top^.Right);
      if HighLeft>HighRight then
        BHigh:=HighLeft+1
      else
        BHigh:=HighRight+1;
    end
  end;
  
Procedure BHoriz(Top:NodePtr; Level:byte);
  begin
    if Top<>Nil then
      if Level=1 then write(Top^.Key)
      else begin
        BHoriz(Top^.Left,Level-1);
        BHoriz(Top^.Right,Level-1);
      end
  end;

Procedure BeautifulViewBT(Top:NodePtr; x,y:byte);
  begin
    GoToXY(x,y); inc(y,2);
    write(Top^.Key);
    if Top^.Left<>Nil then begin
      GoToXY(x-1,y-1); write('/');
      BeautifulViewBT(Top^.Left,x-2,y);
    end;
    if Top^.Right<>Nil then begin
      GoToXY(x+1,y-1); write('\');
      BeautifulViewBT(Top^.Right,x+2,y);
    end
  end;

Procedure ViewBTree(Top:NodePtr);
  Var i, HighTree: byte;
  begin
    HighTree:=BHigh(Top);
    for i:= 1 to HighTree do begin
      writeln;
      BHoriz(Top,i);
    end
  end;
    
Function SearchNode(Top:NodePtr; SearchKey: byte):NodePtr;
  begin
    if Top = Nil then 
      SearchNode := Nil
    else if Top^.Key=SearchKey then SearchNode:=Top
      else if SearchKey<Top^.Key then
        SearchNode:=SearchNode(Top^.Left,SearchKey)
      else SearchNode:=SearchNode(Top^.Right,SearchKey);
  end;
  
Procedure DeleteSubTree(Top:NodePtr);
  Var Tmp:NodePtr; DeleteKey:byte;
  begin
    GoToXY(30,2); writeln('Удаляемая ветка:');
    GoToXY(46,2); readln(DeleteKey); ClrScr;
    Tmp:=SearchNode(Top,DeleteKey);
    if Tmp<>Nil then begin 
      Tmp^.Left:=Nil;
      Tmp^.Right:=Nil;
    end;
  end;
End.
