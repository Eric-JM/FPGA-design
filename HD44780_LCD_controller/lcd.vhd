library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lcd is
port(reset,clock_in,send_data:in std_logic;
  driver:out std_logic_vector(7 downto 0);
  enable,rs:out std_logic
);
end lcd;

architecture a_lcd of lcd is
signal start_count,flag_finishall,send_pressed:std_logic;
signal count:std_logic_vector(22 downto 0);
begin

enable_clock:process(clock_in,reset,start_count)
begin
if rising_edge(clock_in) then
if reset='0' then 
count<=(others=>'0');
--enable<='0';
end if;

if start_count='1'   then 
--enable<='1';
if count=X"7A1200" then --enable<='0';
count<=(others=>'0');

else count<=count+X"1";

end if;

elsif start_count='0' then count<=(others=>'0');
end if;
end if;
end process;


step_timer:process(clock_in,reset)
variable step_count:integer;
begin
if rising_edge(clock_in) then
if reset='0' then
step_count:=0;
start_count<='0';
driver<="00000000";
flag_finishall<='0';
send_pressed<='0';


rs<='0';

end if;
if step_count=215900000 then step_count:=0;
else step_count:=step_count+1;
end if;
if count=X"7A1200" then start_count<='0';
end if;
if flag_finishall='0' then


case step_count is
when 27000000=>driver<="00110000";
start_count<='1';

when 54000000=>driver<="00110000";
start_count<='1';

when 81000000=>driver<="00110000";
start_count<='1';

when 108000000=>driver<="00111000";
start_count<='1';

when 135000000=>driver<="00000110";
start_count<='1';

when 162000000=>driver<="00001111";
start_count<='1';


when 189000000=>driver<="00000001";
start_count<='1';


when 215800000=>flag_finishall<='1';


when others=>null;

end case;

end if;

if send_data='0' and send_pressed='0'  then
rs<='1';
driver<="00110101";
start_count<='1';
send_pressed<='1';

elsif send_data='1'   then 
send_pressed<='0';

end if;


end if;
enable<=start_count;

end process;

end a_lcd;







