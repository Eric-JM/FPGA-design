library ieee;
use ieee.std_logic_1164.all;
entity pulse is
port(command,clk,reset:in std_logic ;pulse_out:out std_logic_vector(1 downto 0));
end pulse;

architecture core of pulse is
  signal hold:std_logic;


begin

gen_pulse:process(clk,command,reset)

begin

if rising_edge(clk) and clk='1'
then
if reset='1' then pulse_out<="00";
hold<='0';
if command='1' and hold='0' then
pulse_out<="11";

hold<='1';
end if;
elsif falling_edge(clk) and clk='0' then
pulse_out<="00";
if command='0' then hold<='0';
end if;
end if;

end process;


end core;
