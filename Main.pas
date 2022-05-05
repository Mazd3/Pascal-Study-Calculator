uses
  crt, Stacks, Files, FilesT, Groups, Queues, Trees;

var
  Mode: integer; Ok: boolean;

begin
  Ok := True;
  while Ok do
  begin
    ClrScr;
    Writeln('Выберите раздел:');
    writeln('  1.Стеки');
    writeln('  2.Очередь');
    writeln('  3.Группа');
    writeln('  4.Файлы');
    writeln('  5.Текстовые Файлы');
    writeln('  6.Дерево');
    Writeln('  0.Выход');
    GoToXY(2, 22);
    Readln(Mode);
    GoToXY(1, 1);
    ClrScr;
    case Mode of
      1: MenuStack;
      2: MenuQueue;
      3: MenuGroup;
      4: MenuFiles;
      5: MenuFilesT;
      6: MenuTrees;
      0: Ok := False;
    else
      begin
        GoToXY(2, 22);
        Writeln('Ошибка! Повторите ввод...');
        delay(2000);
      end
    end
  end
end.