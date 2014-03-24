with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
procedure FileMgr is

  Inputdat : String := "par_4.dat";
  Inputtet : String := "par_4.tet";
  File_1 : Ada.Text_IO.File_Type;
  File_2 : Ada.Text_IO.File_Type;
  m : Integer := 0;
  s : Integer := 0;
  n : Integer := 0;
  nm : Integer := 0;
  k: Integer := 0;
  p: Integer := 0;

begin

  Open(File => File_1, Mode => In_File,
       Name => Inputdat);
  Get(File  => File_1, Item  => m);
  declare
    type dat_array is array (1..m) of Integer;
    time,time_reserv,cost : dat_array;
  begin
    for i in 1..m loop
        Get(File => File_1, Item => time(i));
        Get(File => File_1, Item => time_reserv(i));
        Get(File => File_1, Item => cost(i));
    end loop;
    Get(File => File_1, Item  => s);
    Get(File => File_1, Item  => n);
    Close (File_1);
  end;
  nm := n*m;
  Open(File => File_2, Mode => In_File,
       Name => Inputtet);
  declare

    type tet_array is array(1..nm) of Float;
    test_osn: tet_array;
    test_reserv: tet_array;

   begin
   for i in 1..2*n loop
      if( i rem 2 = 0 )then
        for j in 1..m loop
          k := k + 1;
          Get(File => File_2, Item=> test_osn(k));
          Put(test_osn(k));
         end loop;
      else
      for j in 1..m loop
          p := p + 1;
          Get(File => File_2, Item=> test_reserv(p));
          Put(test_reserv(p));
        end loop;
      end if;
   end loop;
    Close (File_2);
  end;

end FileMgr;
