unit FilesT;
Interface
uses crt;

Procedure MakeAndAddText;
Procedure ViewText;
Procedure Mywrite(stroka: string);
Procedure BadBoys(Exam: byte);
Procedure MenuFilesT;
Implementation

Procedure Wait;
begin
Repeat until KeyPressed;
while KeyPressed do ReadKey;
end;

Procedure Mywrite(Stroka:string);
Var res:string;
    i,n:byte;
 begin
 res:=stroka;
 n:=length(stroka);
 i:=1;
 while (res[i]=' ') and (i<=n) do
 i:=i+1;
 delete(res, 1, i-1);
 write(res);
end;


Procedure MakeAndAddText;
Var ch:char;
    Ok: boolean;
    TextName: string[12];
    Name: string[10];
    Mark: string[3];
    StudentText:Text;
    
Begin
  Writeln('Введите имя файла');
  Readln(TextName);
  assign(StudentText, TextName);
  {$I-}
    append (studentText);
  {$I+}
    if not FileExists(TextName) then
      Rewrite(StudentText);
      Ok:=True;
      While Ok do
        begin
        ClrScr;
   GoToXY(1,1);
   Writeln('Будете ещё вводить?');
   GoToXY(1,2);
   Readln(ch);
   GoToXY(1,1);
   Writeln('   ');
   if (ch='n') then
    begin
    Ok:=False;
    close(StudentText);
    end
     else
      begin
      Clrscr;
      GoToXY(1,1);
      Writeln('Введите фамилию студента');
      GoToXY(1,2);
      readln(Name);
      GoToXY(1,1); Clrscr;
      GoToXY(1,1);
      Writeln('введите его оценки');
      GoToXY(1,2);
      readln(Mark); Clrscr;
      write(StudentText,Name:10,Mark:3);
      end
     end;
    end;
    
    
Procedure ViewText;
Var ch:char;
    Ok: boolean;
    TextName: string[12];
    Name: string[10];
    Mark: string[3];
    StudentText:Text;
    k: integer;
    
Begin
  k:=3;
  Writeln('Ввод имени файла');
  readln(TextName);
  assign(StudentText, TextName);
  {$I-}
    reset(StudentText);
  {$I+}
  if not FileExists(TextName) then
  writeln('Файл', TextName, 'не найден')
    else 
      begin
       While not EOF(StudentText) do
        begin
          k:= k+1;
          read(studentText, Name, Mark);
          GoToXY(1,k); Mywrite(Name);
          GoToXY(12,k); write(Mark);
          end;
        close (StudentText);
       end;
      end;
      



Procedure BadBoys(Exam:byte);
Var ch: char;
    k: byte;
    TextName: string[12];
    Name: string[10];
    Mark: string[3];
    StudentText: Text;
 begin
 k:=3;
 Writeln('Введите имя файла');
 readln(TextName);
 assign(StudentText, TextName);
 {$I-}
  reset(StudentText);
 {$I+}
 if not FileExists(TextName) then
  Writeln('Файл', TextName, 'не найден')
    else
    begin
      While not EOF(StudentText) do
       begin
        read(StudentText, Name, Mark);
        if Mark[Exam]='2' then
          begin
          k:=k+1;
          GoToXY(1,k);
          Mywrite(Name);
         end;
        end;
       close(StudentText);
      end;
     end;


Procedure BadBoys2;
Var i,n,a: integer;
    ch: char;
    k: byte;
    TextName: string[12];
    Name: string[10];
    Mark: string[3];
    StudentText: Text;
 begin
 a:=0;
 k:=3;
 Writeln('Введите имя файла');
 readln(TextName);
 assign(StudentText, TextName);
 {$I-}
 reset(StudentText);
 {$I+}
 if not FileExists(TextName) then
  Writeln('Файл', TextName, 'не найден')
    else
    begin
      While not EOF(StudentText) do
       begin
        read(StudentText, Name, Mark);
        n:=length(Mark);
        a:=0;
        for i:=1 to n do
          if (Mark[i]='2') then a:=a+1;
        if (a=2) then
          begin
          k:=k+1;
          GoToXY(1,k);
          Mywrite(Name);
         end;
        end;
       close(StudentText);
      end;
     end;     
  
  
  
Procedure BadBoys3;
Var i,n,a: integer;
    ch: char;
    k: byte;
    TextName: string[12];
    Name: string[10];
    Mark: string[3];
    StudentText: Text;
 begin
 a:=0;
 k:=3;
 Writeln('Введите имя файла');
 readln(TextName);
 assign(StudentText, TextName);
 {$I-}
  reset(StudentText);
 {$I+}
 if not FileExists(TextName) then
  Writeln('Файл', TextName, 'не найден')
    else
    begin
      While not EOF(StudentText) do
       begin
        read(StudentText, Name, Mark);
        n:=length(Mark);
        a:=0;
        for i:=1 to n do
          if (Mark[i]='2') then a:=a+1;
        if (a=3) then
          begin
          k:=k+1;
          GoToXY(1,k);
          Mywrite(Name);
         end;
        end;
       close(StudentText);
      end;
     end;     
       
  
     
     

Procedure MenuFilesT;
Var Mode : integer;
    Ok: boolean;
begin
  Ok := True;
  While Ok do
    begin
    ClrScr;
      Writeln('Выберите команду:');
      Writeln('  1.Создать текстовый файл');
      Writeln('  2.Посмотреть файл');
      Writeln('  3.Должники по истории');
      Writeln('  4.Должники по аналитической геометрии');
      Writeln('  5.Должники по математическому анализу');
      Writeln('  6.Долг по нескольким экзаменам');
      Writeln('  7.На отчисление');
      Writeln('  0.Назад');
    Readln(Mode);
    ClrScr;
    case Mode of
      1:begin 
          MakeAndAddText;
        end;
      2: begin
            ViewText;
            wait;
         end;
      3: begin
            BadBoys(1);
            wait;
         end;
      4: begin
            BadBoys(2);
            wait;
         end;
      5: begin
            BadBoys(3);
            wait;      
         end;
      6: begin
            BadBoys2;
            wait;      
         end;
      7: begin
            BadBoys3;
            wait;      
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