library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stepper is
port(rst,clk,speed,slow,direction:in std_logic;
	drive:out std_logic_vector(3 downto 0)
	
);
end stepper;

architecture core_stepper of stepper is
signal step_cnt:unsigned(20 downto 0);
signal incr:unsigned(19 downto 0);
signal buf_out : std_logic_vector(3 downto 0);
begin

counting : process(clk,rst)
begin
if rising_edge(clk) then
if rst='0' then
step_cnt<=(others=>'0');

elsif step_cnt=X"107AC0"-incr then step_cnt<=(others=>'0');

else step_cnt<=step_cnt+X"1";

end if;
end if;
end process;


driving : process(clk,rst,direction)
begin
if rising_edge(clk)
then if rst='0' then
buf_out<=(others=>'0');
end if;
if direction='0' then
if step_cnt=X"0" then buf_out<="1001";
elsif step_cnt=(X"107AC0"-incr)/X"4" then buf_out<="0101";
elsif step_cnt=(X"107AC0"-incr)/X"2" then buf_out<="0110";
elsif step_cnt= 3*(X"107AC0"-incr)/X"4"then buf_out<="1010";
end if;

elsif direction='1' then

if step_cnt=X"0" then buf_out<="1010";
elsif step_cnt=(X"107AC0"-incr)/X"4" then buf_out<="0110";
elsif step_cnt=(X"107AC0"-incr)/X"2" then buf_out<="0101";
elsif step_cnt= 3*(X"107AC0"-incr)/X"4"then buf_out<="1001";
end if;

end if;
end if;
end process;

incrementing:process(clk,rst,speed,slow)
variable flag1,flag2:integer;
begin
if rising_edge(clk) then
if rst='0' then incr<=(others=>'0');
flag1:=0;
flag2:=0;

end if;
if speed='0' and flag1=0 then
incr<=incr+X"3E80";
flag1:=1;
elsif speed='1' then flag1:=0;
end if;

if slow='0' and flag2=0 then
incr<=incr-X"3E80";
flag2:=1;
elsif slow='1' then flag2:=0;
end if;
end if;

end process;


drive<=buf_out;


end core_stepper;







