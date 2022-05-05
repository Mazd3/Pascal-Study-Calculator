unit Files;

    Interface

uses crt,Stacks;

Type Student = record
     Name: string [10];
     Mark: string [5];
     end;
     
Procedure MakeFile;
Procedure ViewFile;
Procedure AddFile;
Procedure MenuFiles;

    Implementation

Procedure MakeFile;
var ch:char; Ok:boolean; FileName: string[12];
StudentFile: file of student; Flow: Student;
begin
  Ok:=True;
  Writeln('Дайте файлу имя');
  Readln(FileName);
  assign(StudentFile, FileName);
  rewrite(StudentFile); 
  with Flow do
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
       close(StudentFile);
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
       write(StudentFile, Flow);
      end
    end;
end;
    

Procedure ViewFile;
var k:integer; ch:Char; FileName: string[12];
StudentFile: file of student; Flow : Student;
begin
  k:=3;   
  Writeln('Введите имя файла');
  readln(FileName);
  assign(StudentFile,FileName);
  reset(StudentFile);
  With Flow do
   while not EOF(StudentFile) do
     begin
       k:= k+1;
       read(StudentFile,Flow); 
       GoToXY(1,k);
       Write(Name);
       GoToXY(11, k);
       Write(Mark);
      end;
   Close(StudentFile);
end;
      
procedure AddFile;
Var ch: char; Ok:boolean;
FileName,NewName:string;
StudentFile,NewFile:File of student; Flow: Student;
begin
  Ok:=True;
  Writeln('Введите имя файла');
  Readln(FileName);
  assign(StudentFile, FileName);
  reset(StudentFile);
  NewName:='aaa';
  assign(NewFile,NewName);
  Rewrite(NewFile);
  While not EOF(StudentFile) do
   begin
    read(StudentFile,Flow);
    write(NewFile,Flow);
   end;
  Close(StudentFile);
  with Flow do
    While Ok do
     begin
      Clrscr;
      GoToXY(1,1);
      Writeln('Будете ещё вводить?');
      GoToXY(1,2);
      Readln(ch); Clrscr;
      if ch='n' then
        begin
         Ok:=False;
         close(NewFile);
        end
      else
       begin
       Clrscr;
        GoToXY(1,1);
        writeln('Введите фамилию студента');
        GoToXY(1,2);
        Readln(Name); Clrscr;
        GoToXY(1,1);
        Writeln('Введите его оценки');
        GoToXY(1,2);
        Readln(Mark); Clrscr;
        Write(NewFile,Flow);
       end;
     end;
   erase(StudentFile);
   rename(NewFile,FileName);
end;
  
  
Procedure Wait;
begin
  Repeat until KeyPressed;
  while KeyPressed do ReadKey;
end;
 
  
Procedure MenuFiles;
Var Mode : integer; Ok: boolean;
begin
  Ok := True;
  While Ok do
    begin
    ClrScr;
      Writeln('Выберите команду:');
      Writeln('  1.Создать файл');
      Writeln('  2.Посмотреть файл');
      Writeln('  3.Добавить файл');
      Writeln('  0.Назад');
    Readln(Mode);
    ClrScr;
    case Mode of
      1:begin 
          MakeFile;
        end;
      2: begin
            ViewFile;
            wait;
         end;
      3: begin
            AddFile;
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