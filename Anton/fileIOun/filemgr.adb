with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
package body FileMgr is  
  

  procedure readParamsScheme (
      Inputdat : in String;
      File_1 : in out Ada.Text_IO.File_Type;
      m : in out Integer;
      s : in out Integer;
      n : in out Integer;
      time : in out dat_array;
      time_reserv : in out dat_array;
      cost : in out dat_array
  ) is begin
    Open(File => File_1, Mode => In_File,
       Name => Inputdat);
    Get(File  => File_1, Item  => m);
    declare
      time : dat_array (1..m);
      time_reserv :  dat_array(1..m);
      cost :  dat_array(1..m);
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
  end readParamsScheme;
  
  procedure readTestData (
    Inputtet : in String;
	File_2 : in out Ada.Text_IO.File_Type;	
	m : in  Integer;
	n : in  Integer;
	test_osn : in out tet_array;
	test_reserv: in out tet_array
  ) is begin
    nm := n*m;
    Open(File => File_2, Mode => In_File,
       Name => Inputtet);
	declare
      test_osn: tet_array (1..nm);
	  test_reserv: tet_array (1..nm);
      k: Integer := 0;
      p: Integer := 0;
    begin
      for i in 1..2*n loop
        if( i rem 2 = 0 )then
          for j in 1..m loop
            k := k + 1;
            Get(File => File_2, Item=> test_osn(k));
            --Put(test_osn(k));
          end loop;
        else
          for j in 1..m loop
            p := p + 1;
            Get(File => File_2, Item=> test_reserv(p));
           --Put(test_reserv(p));
          end loop;
        end if;
      end loop;
      Close (File_2);
    end;
  end readTestData;
  
begin 
  null;
end FileMgr;
