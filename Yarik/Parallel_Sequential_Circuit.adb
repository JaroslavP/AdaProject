with Ada.Text_IO;				use Ada.Text_IO;
with Ada.Integer_Text_IO; 			use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;				use Ada.Float_Text_IO;
with Ada.Numerics.Elementary_Functions;		use Ada.Numerics.Elementary_Functions;

procedure Parallel_Sequential_Circuit is
   
   -- NetWork Struck
   type Mass_CnParElm is array (1..150) of Integer; 
   type main_data_row is array (1..3) of Integer ;
   type main_data is array (1..150) of main_data_row;
   type Par_Seq is tagged 
     record
	CnBranch:Integer; -- number of branch
	CnParElm: Mass_CnParElm; -- count of element in branch
	minData: main_data; -- O_o
        C: Integer := 0; -- money
        N:Integer := 0; -- trying
   end record;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- the initial data
   function GetNetWork (LocFileName: String) return Par_Seq is 
      LocData: Par_Seq;
      inputFile :File_Type;
      kBegin, kEnd :integer;
   begin
      Open(inputFile,In_File, LocFileName);	
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
   function Sum_of_elements (LocNetWork:Par_Seq) return Integer is
   	LocSum: Integer := 0;
   begin
      for Count in 1..LocNetWork.CnBranch loop
         LocSum := LocSum + LocNetWork.CnParElm(Count);
      end loop;
      return LocSum;
   end Sum_of_elements;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- random live time
   type random_time_row is array (1..150) of Float;
   type random_time is array (1..150) of random_time_row;
     type RandonLiveTime is tagged
      record
         main_time: random_time;
         reserve_time: random_time;
      end record;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- randon live time
   function GetRandomLiveTime (LocNetWork:Par_Seq; LocSumElement:integer; LocFileName:String) return RandonLiveTime is
      LocTimeOGar: RandonLiveTime;
      input_tet_file: File_Type;
   begin
      Open(input_tet_file, In_File, LocFileName);
      for iCount in 1..LocNetWork.N loop
         for jCount in 1..LocSumElement loop
             Get(input_tet_file, LocTimeOGar.reserve_time(iCount)(jCount));
         end loop;
         for lCount in 1..LocSumElement loop
            Get(input_tet_file, LocTimeOGar.main_time(iCount)(lCount));
         end loop;
      end loop;
      Close(input_tet_file);
      return LocTimeOGar;
   end GetRandomLiveTime;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- Create  PlanX
   type plan_type is array (1..150) of Integer;
   -- UP by one some plan (form iBegin..iEnd)
   function GetPlanX(LocPlanX: in out plan_type; iBegin:integer; iEnd:integer) return plan_type is
      xCount:integer;
      plusOne:integer;
   begin
      if (LocPlanX(iEnd) = 0)
      then LocPlanX(iEnd) := 1;
      elsif (LocPlanX(iEnd) = 1)
      then
         LocPlanX(iEnd) := 0;
         xCount := iEnd - 1;
         plusOne := 1;
            while((plusOne = 1) and (xCount >= iBegin)) loop
            if (LocPlanX(xCount) = 0)
            then 
               LocPlanX(xCount) := 1;
               plusOne := 0;
            else 
               LocPlanX(xCount) := 0;
            end if;
            xCount := xCount - 1;
         end loop;
      end if;
      return LocPlanX;
   end GetPlanX;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
     -- Output
   procedure OutputData(LocNetWork:Par_Seq; LocPlan:plan_type; LocF:Float; LocOutFile:String) is
      locCount_1, LocCount_2: Integer;
      outPut: File_Type;
   begin
      Open(outPut, Out_File, LocOutFile);
      LocCount_2 := 0;
      for Count in 1..LocNetWork.CnBranch loop
         LocCount_1 := LocCount_2 + 1;
         LocCount_2 := LocCount_2 + LocNetWork.CnParElm(Count);
         for jCount in locCount_1..LocCount_2 loop
            Put(LocPlan(jCount),0); Put(" ");
            Put(outPut, LocPlan(jCount),0);Put(outPut," ");
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
   type minMass is array (1..150) of Float;
   function FinderMathEx(LocNetWork:Par_Seq; LocPlan:plan_type; LocTime:RandonLiveTime) return Float is
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
   end FinderMathEx;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- Find Honey
   function Honey (LocNetWork:Par_Seq; LocPlan: plan_type; LocSumElement:Integer) return Integer is
   	sumHoney: Integer := 0;
   begin
      for Count in 1..LocSumElement loop
         sumHoney := sumHoney + LocNetWork.minData(Count)(3)*LocPlan(Count);
      end loop;
      return sumHoney;
   end Honey;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- find Best Plan 
   function FindBestPlan(LocNetWork:Par_Seq; LocPlan:in out plan_type; Loc_live_time:RandonLiveTime; LocSumElement:Integer) return Float is
      LocF, tempF: Float;
      LocMoney: integer;
      BestPlan: plan_type;
      CheckOut: Integer := 0;
   begin
      LocF := FinderMathEx(LocNetWork, LocPlan, Loc_live_time);
      while (CheckOut /= 20) loop        
         LocPlan := GetPlanX(LocPlan,1,LocSumElement);
         LocMoney := Honey(LocNetWork, LocPlan, LocSumElement);
         if(LocMoney <= LocNetWork.C) then
            tempF := FinderMathEx(LocNetWork, LocPlan, Loc_live_time);
            if (tempF > LocF) then
               LocF := tempF;
               BestPlan := LocPlan;
            end if;
         end if;
         CheckOut := 0;
         for ikCount in 1..LocSumElement loop
            CheckOut := CheckOut + LocPlan(ikCount);
         end loop;
      end loop;
      LocPlan := BestPlan;
      return LocF;
   end FindBestPlan;
   -- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
   
   -- Main Values  
   NetWork: Par_Seq;
   InFile: String := "par_seq_06.dat";
   SumElement :Integer;
   live_time: RandonLiveTime;
   InFileTime: String := "par_seq_06.tet";
   PlanX: plan_type;
   OutFile: String := "Parallel_Sequential_output.dat";
   BestF:Float;
   HoneyMoney: Integer;
-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
begin
   NetWork := GetNetWork(InFile);
   --Put(NetWork.C);
   SumElement := Sum_of_elements(NetWork);
   live_time := GetRandomLiveTime(NetWork,SumElement,InFileTime);
   for Count in 1..SumElement loop
     PlanX(Count) := 0;
   end loop;	     
   BestF := FindBestPlan(NetWork, PlanX, live_time, SumElement);
   OutputData(NetWork, PlanX,BestF, OutFile); New_Line;
   HoneyMoney := Honey(NetWork, PlanX,SumElement);
   Put("HoneyMoney = ");Put(HoneyMoney,0);
end Parallel_Sequential_Circuit;
