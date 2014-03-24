with Ada.Text_IO;
package FileMgr is

  type dat_array is array (Integer range <>) of Integer;
  type tet_array is array(Integer range <>) of Float;

  nm : Integer := 0;

  procedure readParamsScheme (
      Inputdat : in String;
      File_1 : in out Ada.Text_IO.File_Type;
      m : in out Integer;
      s : in out Integer;
      n : in out Integer;
      time : in out dat_array;
      time_reserv : in out dat_array;
      cost : in out dat_array
  );

  procedure readTestData (
      Inputtet : in String;
      File_2 : in out Ada.Text_IO.File_Type;
      m : in  Integer;
      n : in  Integer;
      test_osn : in out tet_array;
      test_reserv: in out tet_array
  );
end FileMgr;
