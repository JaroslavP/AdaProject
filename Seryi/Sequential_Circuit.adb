with Ada.Text_IO;		use Ada.Text_IO;
with Ada.Integer_Text_IO; 	use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;		use Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions; use Ada.Numerics.Elementary_Functions;

procedure Sequential_Circuit is
   
   type main_data_row is array (1..3) of Integer ;
   type main_data is array (1..100) of main_data_row;

      type SeqData is tagged 
     record
	M: Integer;
	minData: main_data; -- O_o
        C: Integer := 0; -- money
        N:Integer := 0; -- trying
      end record;
   
   function GetDataFromFile return SeqData is 
      inputFile  :File_Type;
      inputData:SeqData;
     begin
        Open(inputFile,In_File,"Sequential_Circuit_input_test.dat");
        Get(inputFile,inputData.M);
      for Count in 1..inputData.M loop
         for inCount in 1..3 loop
            Get(inputFile,inputData.minData(Count)(inCount));
         end loop;
         New_Line;
      end loop;
      Get(inputFile,inputData.C);
      Get(inputFile,inputData.N);
        Close(inputFile);
       	return inputData;
   end GetDataFromFile;
   
    type random_time_row is array (1..100) of Float;
    type random_time is array (1..100) of random_time_row;
     type RandonLiveTime is tagged
      record
         main_time: random_time;
         reserve_time: random_time;
      end record;
   
      function GetRandomLiveTime return RandonLiveTime is
      LocTimeOGar: RandonLiveTime;
      input_tet_file: File_Type;
   begin
      Open(input_tet_file, In_File, "Sequential_input_test.tet");
      for iCount in 1..100 loop
         for jCount in 1..20 loop
             Get(input_tet_file, LocTimeOGar.reserve_time(iCount)(jCount));
         end loop;
         for lCount in 1..20 loop
            Get(input_tet_file, LocTimeOGar.main_time(iCount)(lCount));
         end loop;
      end loop;
      Close(input_tet_file);
      return LocTimeOGar;
   end GetRandomLiveTime;
   
   -- Create  PlanX
   type plan_type is array (1..100) of Integer;
   PlanX: plan_type;
   
   function GetPlanX(iBegin:integer; iEnd:integer) return plan_type is
      xCount:integer;
      plusOne:integer;
   begin
      if (PlanX(iEnd) = 0)
      then PlanX(iEnd) := 1;
      elsif (PlanX(iEnd) = 1)
      then 
         PlanX(iEnd) := 0;
         xCount := iEnd - 1;
         plusOne := 1;
         while(plusOne = 1) loop
            if (PlanX(xCount) = 0)
            then 
               PlanX(xCount) := 1;
               plusOne := 0;
            else 
               PlanX(xCount) := 0;
            end if;
            xCount := XCount - 1;
         end loop;
      end if;
      return PlanX;
   end GetPlanX;
   
      -- Finder  Plan
   type minMass is array (1..100) of Float;
   function FinderPlan(LocNetWork:SeqData; LocTime:RandonLiveTime; LocPlan:plan_type) return Float is
      LocSum:Float := 0.0;
      LF, Te, Tay, E:Float;
      min_mass: minMass;
   begin
      LF :=0.0;
      for minCount in 1..20 loop
         min_mass(minCount) := 99999.0;
      end loop;
      for kCount in 1..100 loop
         for iCount in 1..20 loop
               Te := Float(LocNetWork.minData(iCount)(1)) * Log(1.0/(1.0 - LocTime.main_time(kCount)(iCount)));
               Tay := Float(LocNetWork.minData(iCount)(2)) * Log(1.0/(1.0 - LocTime.reserve_time(kCount)(iCount)));
               E := Te * Float(LocPlan(iCount))*Tay;
               if (E < min_mass(iCount)) then min_mass(iCount) := E;
                  end if;
         end loop;   
         for Count in 1..20 loop
            LF := LF + min_mass(Count);
         end loop;
      end loop;
      return LF/100.0;
   end FinderPlan;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
      -- Output
   procedure OutputData(LoxPlan:plan_type; LocF:Float) is
      outPut: File_Type;
   begin
      Open(outPut, Out_File,"Sequential_output.dat");
         for jCount in 1..20 loop
            Put(PlanX(jCount),0); Put(" ");
            Put(outPut, PlanX(jCount),0);Put(outPut," ");
         end loop;
         New_Line;
         Put_Line(outPut,"");  
      Put("F(x) = "); Put(LocF);
      Put(outPut, "F(x) = "); Put(outPut, LocF);
      Close(outPut);
   end OutputData;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
      -- Find Honey
   function Money (LocNetWork:SeqData; LocPlan: plan_type) return Integer is
   	sumHoney: Integer := 0;
   begin
      for Count in 1..20 loop
         sumHoney := sumHoney + LocNetWork.minData(Count)(3)*LocPlan(Count);
      end loop;
      return sumHoney;
   end Money;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   NetData : SeqData;
   live_time: RandonLiveTime;
   Plan:plan_type;
   FPlan: Float;
   mon: Integer;
   
begin	
   NetData := GetDataFromFile;
   live_time := GetRandomLiveTime;
   Plan := GetPlanX(1,20);
   
   FPlan := FinderPlan(NetData,live_time,Plan);
   
   for jCount in 1..20 loop
         Put(PlanX(jCount),0);
         Put(" ");
   end loop;
  
   mon := Money(NetData,Plan);
   New_Line;
   Put("Money: ");
   Put(mon,2);
   New_Line;
   OutputData(Plan, FPlan);
   
--        Put("C:= ");
--        Put(NetData.C,2);
--        New_Line;
--        Put("N:= ");
--        Put(NetData.N,2);
end Sequential_Circuit;
