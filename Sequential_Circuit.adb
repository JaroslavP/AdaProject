with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO; 	use Ada.Integer_Text_IO;

procedure Sequential_Circuit is
   
   type Mass_Row is array ( 1..3 ) of Integer ;
   type Mass is array ( 1..100 ) of Mass_Row;


   function ReadF return Mass is 
       inputFile  :File_Type;
  --        outputFile :File_Type;
       n,tmpI:Integer;
       inputData : Mass;
     begin
        Open(inputFile,In_File,"Sequential_Circuit_input_test.txt");
        Get(inputFile,n);
      for Count in 1..n loop
         for inCount in 1..3 loop
            Get(inputFile,inputData(Count)(inCount));
            Put(inputData(Count)(inCount));
            tmpI := Count;
         end loop;
         New_Line;
      end loop;
      Get(inputFile,inputData(tmpI+1)(1));
      Get(inputFile,inputData(tmpI+1)(2));
--        inputData(tmpI+1)(1) := m;
--        inputData(tmpI+1)(2) := c;
        Close(inputFile);
       	return inputData;
     end ReadF;
   
   inputData : Mass;
   n : Integer;
       inputFile  :File_Type;
begin	
   Open(inputFile,In_File,"input.txt");
   Get(inputFile,n);
   Close(inputFile);
   inputData := ReadF;
      for Count in 1..n loop
         for inCount in 1..3 loop
            Put(inputData(Count)(inCount));
         end loop;
         New_Line;
   end loop;   
      Put("M:= ");
      Put(inputData(n+1)(1),1);
      New_Line;
      Put("C:= ");
      Put(inputData(n+1)(2),2);
end Sequential_Circuit;
