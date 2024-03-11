library ieee;
use ieee.std_logic_1164.all;

entity testbench_pulse is
end testbench_pulse;

architecture test_core of test_pulse is
component pulse port(command,clk,reset:in std_logic ; pulse_out:out std_logic_vector(1 downto 0));

end component;

signal comm,clock,rst:std_logic;
signal pulse_output:std_logic_vector(1 downto 0);

begin
assign:pulse port map(command=>comm, clk=>clock, reset=>rst, pulse_out=>pulse_output);

sequencement: process
  begin
    clock <='0';
    wait for 5 ns;
    loop
    clock<= not clock;
   wait for 5 ns;
   end loop;
  end process;

stimuli : process
begin
comm<='0';
rst<='0';
wait for 20 ns;
rst<='1';
wait for 100 ns;
rst<='0';
wait for 20 ns;
comm<='1';
wait for 160 ns;
comm<='0';
wait for 200 ns;
comm<='1';
wait for 180 ns;
end process;

end test_core;
