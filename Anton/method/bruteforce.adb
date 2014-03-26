package body bruteforce is

  procedure Inc_array (arr : in out type_arr)  is
  i:Integer := 1;
  begin
    while (arr(i) /= 0) loop
      i := i + 1;
    end loop;
    arr(i):= 1;
    for j in 1..i-1 loop
      arr(j):= 0;
    end loop;
  end Inc_array;

begin
null;
end bruteforce;
