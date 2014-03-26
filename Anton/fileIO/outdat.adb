with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
procedure OutDat is

  Outputdat : String := "Output.dat";
  Output : Ada.Text_IO.File_Type;
  m: Integer := 10;
  type res_array is array (1..m) of Integer;
  x: res_array;
  Fx: Float := 0.1;
begin
  Open(File => Output, Mode => Out_File,
       Name => Outputdat);

  for i in 1..m loop
     x(i):= 1;
  end loop;
  for i in 1..m loop
     Put(File  => Output, Item => x(i));
  end loop;
  Put_Line(File => Output, Item => "");
  Put(File => Output, Item => Fx);
  Close (Output);
end OutDat;
