with Ada.Text_IO, Ada.Numerics.Elementary_Functions, FileMgr, bruteforce ;
use Ada.Text_IO, Ada.Numerics.Elementary_Functions, FileMgr, bruteforce;

procedure FunctCalc is

  function functLiveTime(
                         x: Float;
      time:Float;
      time_reserv:Float;
      w_osn:Float;
      w_reserv:Float) return Float is
  begin
  return (time * Log(1.0/(1.0 - w_osn)) + x * time_reserv * Log(1.0/(1.0-w_reserv)));
  end functLiveTime;

  function findMax (el1 : Float;
     el2 : Float) return Float  is
  begin
    if  (el1 > el2) then
      return el1;
    else
      return el2;
    end if;
  end findMax;

  function findMaxElement(time: tet_array;
     time_reserv: tet_array;
     x: tet_array;
     m: Integer;
     w_osn : tet_array;
     w_reserv : tet_array) return Float is

    max : Float := 0.0;
    value_funct : Float;
    i : Integer;
  begin
    i := 1;
    max := functLiveTime(x(i), time(i), time_reserv(i), w_osn(i), w_reserv(i));
    for i in 2..m loop
      value_funct := functLiveTime(x(i), time(i), time_reserv(i), w_osn(i), w_reserv(i));
      max := findMax(max, value_funct);
    end loop;

    return max;
  end findMaxElement;

  procedure subArr(src : tet_array;
      from : Integer;
      to: Integer;
      mas : in out tet_array) is
  i : Integer := 1;
  begin

  for j in from..to loop
      mas(i) := src(j);
      i := i + 1;
  end loop;

  end subArr;

  function costCalc(m : Integer;
     c : tet_array;
     x : tet_array;
     S: Float) return boolean is
  sum : Float := 0.0;
  begin
    for i in 1..m loop
      Sum := c(i)*x(i) + Sum;
   end loop;
  return  S >= Sum;
  end costCalc;
begin
  null;
end FunctCalc;
