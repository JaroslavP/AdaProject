with bruteforce, filemgr, Ada.Text_IO, Ada.Integer_Text_IO,  Ada.Float_Text_IO;
use bruteforce, filemgr, Ada.Text_IO,  Ada.Integer_Text_IO,  Ada.Float_Text_IO;

procedure Main is
  Inputdat : String := "par_4.dat";
  Inputtet : String := "par_4.tet";
  File_1 : Ada.Text_IO.File_Type;
  File_2 : Ada.Text_IO.File_Type;

  time : dat_array(1..10000);
  time_reserv : dat_array(1..10000);
  cost : dat_array(1..10000);
  test_osn : tet_array(1..10000);
  test_reserv: tet_array(1..10000);

  m:Integer := 0;
  C:Integer := 200;
  n:Integer := 0;
  s:Integer := 0;
begin
  readParamsScheme (Inputdat,	File_1, m, s, n, time, time_reserv, cost);
  readTestData (Inputtet, File_2, m, n, test_osn, test_reserv);
  declare
    cost_mas : type_arr (1..m);
  begin
    for k in 1..m loop
      cost_mas(k) := 0;
    end loop;
    for i in 1..(2**m)-1 loop
      Inc_array(cost_mas);
      for j in 1..m loop
        Put(cost_mas(j));
      end loop;
      Put_Line("");
     end loop;
    end;
end Main;
