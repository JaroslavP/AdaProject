with Ada.Text_IO;				use Ada.Text_IO;
with Ada.Integer_Text_IO; 			use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;				use Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions;		use Ada.Numerics.Elementary_Functions;

procedure Parallel_Sequential_Circuit is
   
   -- NetWork Struck
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
   
   -- Create  PlanX
   type plan_type is array (1..100) of Integer;
   PlanX: plan_type;
   -- UP by one some plan (form iBegin..iEnd)
   procedure GetPlanX(iBegin:integer; iEnd:integer) is
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
            while((plusOne = 1) and (xCount >= iBegin)) loop
               --Put(xCount); Put("xC");
            if (PlanX(xCount) = 0)
            then 
               PlanX(xCount) := 1;
               plusOne := 0;
            else 
               PlanX(xCount) := 0;
            end if;
            xCount := xCount - 1;
         end loop;
      end if;
   end GetPlanX;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
      
   -- Output
   procedure OutputData(LoxPlan:plan_type; LocF:Float) is
      locCount_1, LocCount_2: Integer;
      outPut: File_Type;
   begin
      Open(outPut, Out_File,"Parallel_Sequential_input_test.dat");
      LocCount_2 := 0;
      for Count in 1..NetWork.CnBranch loop
         LocCount_1 := LocCount_2 + 1;
         LocCount_2 := LocCount_2 + NetWork.CnParElm(Count);
         for jCount in locCount_1..LocCount_2 loop
            Put(PlanX(jCount),0); Put(" ");
            Put(outPut, PlanX(jCount),0);Put(outPut," ");
         end loop;
         New_Line;
         Put_Line(outPut,"");
      end loop;   
      Put("F(x) = "); Put(LocF);
      Put(outPut, "F(x) = "); Put(outPut, LocF);
      Close(outPut);
   end OutputData;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- Finder  Plan
   type minMass is array (1..100) of Float;
   function FinderPlan(LocNetWork:Par_Seq; LocTime:RandonLiveTime; LocPlan:plan_type) return Float is
      LocSum:Float := 0.0;
      max:Float;
      LF, Te, Tay, E:Float;
      min_mass: minMass;
      jBegin, jEnd: Integer;
   begin
      for minCount in 1..LocNetWork.CnBranch loop
         min_mass(minCount) := 99999.0;
      end loop;
      for kCount in 1..LocNetWork.N loop
         jEnd := 0;
         for iCount in 1..LocNetWork.CnBranch loop
            jBegin := jEnd + 1;
            jEnd := jEnd + LocNetWork.CnParElm(iCount);
            for jCount in jBegin..jEnd loop
               Te := Float(LocNetWork.minData(jCount)(1)) * Log(1.0/(1.0 - LocTime.main_time(kCount)(jCount)));
               Tay := Float(LocNetWork.minData(jCount)(2)) * Log(1.0/(1.0 - LocTime.reserve_time(kCount)(jCount)));
               E := Te * Float(LocPlan(jCount))*Tay;
               if (E < min_mass(iCount)) then min_mass(iCount) := E;
                  end if;
            end loop;   
         end loop;
         max := -99999.0;
         for mmCount in 1..LocNetWork.CnBranch loop
            if (min_mass(mmCount) > max) then max := min_mass(mmCount);
               end if;
         end loop;
         LocSum := LocSum + max;
      end loop;
      LF := LocSum/Float(LocNetWork.N);
      return LF;
   end FinderPlan;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- Find Honey
   function Honey (LocNetWork:Par_Seq; LocPlan: plan_type) return Integer is
   	sumHoney: Integer := 0;
   begin
      for Count in 1..SumElement loop
         sumHoney := sumHoney + LocNetWork.minData(Count)(3)*LocPlan(Count);
      end loop;
      return sumHoney;
   end Honey;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- find Best Plan 
   function FindBestPlan(LocNet:Par_Seq) return Float is
      LocF, tempF: Float;
      LocMoney: integer;
      BestPlan: plan_type;
      CheckOut: Integer := 0;
   begin
      for Count in 1..SumElement loop
         PlanX(Count) := 0;
      end loop;
      LocF := FinderPlan(NetWork, live_time, PlanX);
      while (CheckOut /= 20) loop        
--           jE := 0;
--           for iCount in 1..LocNet.CnBranch loop
--              jB := jE + 1;
--              jE := jE + LocNet.CnParElm(iCount);
         GetPlanX(1,SumElement);
--           end loop;
         LocMoney := Honey(LocNet, PlanX);
         if(LocMoney <= LocNet.C) then
            tempF := FinderPlan(NetWork, live_time, PlanX);
            if (tempF > LocF) then
               LocF := tempF;
               Put(LocF);Put_Line("");
               BestPlan := PlanX;
            end if;
         end if;
         CheckOut := 0;
         for ikCount in 1..SumElement loop
            CheckOut := CheckOut + PlanX(ikCount);
         end loop;
      end loop;
      PlanX := BestPlan;
      return LocF;
   end FindBestPlan;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
-- LoC Values  
   BestF:Float;
   --HoneyMoney: Integer;
-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
begin
   NetWork := GetNetWork;
   SumElement := Sum_of_elements;
   live_time := GetRandomLiveTime;
      
 
   BestF := FindBestPlan(NetWork);
   OutputData(PlanX,BestF); New_Line;
   --GetPlanX(13,15);
   --BestF := 0.0;
   --outputData(PlanX,BestF);
   --New_Line;
   --HoneyMoney := Honey(NetWork, PlanX);
   --Put("HoneyMoney = ");Put(HoneyMoney,0);
end Parallel_Sequential_Circuit;
