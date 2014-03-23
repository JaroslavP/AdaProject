with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO; 	use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;

procedure Parallel_Sequential_Circuit is
   
   type Mass_CnParElm is array (1..100) of Integer; 
   type main_data_row is array (1..3) of Integer ;
   type main_data is array (1..100) of main_data_row;
   type Par_Seq is tagged 
     record
	CnBranch:Integer; -- number of branch
	CnParElm: Mass_CnParElm; -- count of element in branch
	minData: main_data; -- O_o
        C: Integer := 0; -- money
        N:Integer := 0; -- trying
   end record;
   NetWork: Par_Seq; 
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- the initial data
   function GetNetWork return Par_Seq is 
      inputFile :File_Type;
      kBegin, kEnd :integer;
      LocData: Par_Seq;
   begin
      Open(inputFile,In_File,"Parallel_Sequential_input_test.dat");
      Get(inputFile, LocData.CnBranch);
      kEnd := 0; 
      for Count in 1..LocData.CnBranch loop
         kBegin := kEnd + 1;
         Get(inputFile, LocData.CnParElm(Count));
         kEnd := kEnd + LocData.CnParElm(Count);
         for iCount in kBegin..kEnd loop
            for jCount in 1..3 loop
            	Get(inputFile, LocData.minData(iCount)(jCount));
            end loop;
         end loop;
      end loop;
      Get(inputFile, LocData.C);
      Get(inputFile, LocData.N);
      Close(inputFile);
      return LocData;
   end GetNetWork;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

   -- number of element 
   function Sum_of_elements return Integer is
   	LocSum: Integer := 0;
   begin
      for Count in 1..5 loop
         LocSum := LocSum + NetWork.CnParElm(Count);
      end loop;
      return LocSum;
   end Sum_of_elements;
   SumElement :Integer := 0;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- random live time
   type random_time_row is array (1..100) of Float;
   type random_time is array (1..100) of random_time_row;
     type RandonLiveTime is tagged
      record
         main_time: random_time;
         reserve_time: random_time;
      end record;
   live_time: RandonLiveTime;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- randon live time
   function GetRandomLiveTime return RandonLiveTime is
      LocTimeOGar: RandonLiveTime;
      input_tet_file: File_Type;
   begin
      Open(input_tet_file, In_File, "Parallel_Sequential_input_test.tet");
      for iCount in 1..NetWork.N loop
         for jCount in 1..SumElement loop
             Get(input_tet_file, LocTimeOGar.reserve_time(iCount)(jCount));
         end loop;
         for lCount in 1..SumElement loop
            Get(input_tet_file, LocTimeOGar.main_time(iCount)(lCount));
         end loop;
      end loop;
      Close(input_tet_file);
      return LocTimeOGar;
   end GetRandomLiveTime;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- Finder  Plan

   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

begin
   NetWork := GetNetWork;
   Put(NetWork.C);
   SumElement := Sum_of_elements;
   live_time := GetRandomLiveTime;
	   
end Parallel_Sequential_Circuit;
