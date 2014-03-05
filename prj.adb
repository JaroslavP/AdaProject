with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO; 	use Ada.Integer_Text_IO;
with Parallel_Circuit;
with Sequential_Circuit;
with Parallel_Sequential_Circuit;

procedure prj is
	CValue: Integer := 0;
begin
   --while (CValue /= 4) loop
      Put("Choose variable: ");
      Get(CValue);
   case CValue is

      when 1 => Parallel_Circuit;

      when 2 => Sequential_Circuit;

      when 3 => Parallel_Sequential_Circuit;
      when others => Put("other");
   end case;
   --end loop;
end prj;
