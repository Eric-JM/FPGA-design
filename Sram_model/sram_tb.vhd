
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity tb_sram is
end tb_sram;

architecture simsram of tb_sram is
constant f : integer := 16;
  component sram
   port (data :in std_logic_vector(f-1 downto 0);
   q : out std_logic_vector(f-1 downto 0);
   address : in std_logic_vector(3 downto 0);
   clk,reset,WEN : in std_logic);

  end component;

  signal donnee, sortie : std_logic_vector(f-1 downto 0);
  signal addr : std_logic_vector(3 downto 0);
  signal  horloge,mise0, enable : std_logic;
  
begin  -- simsram

  clock: process
    begin
     horloge<='0';
     wait for 20 ns;
     horloge<='1';
     wait for 20 ns;
    end process;

 assign: sram
   port map (
     data=>donnee, q=>sortie, clk=>horloge, address=>addr, reset=>mise0, WEN=>enable);


    stimuli: process
  begin
   mise0<='0';
   enable<='0';
   addr<="0000";
   donnee<=(others=>'0');
   wait for 12 ns;
   
   for j in 0 to 15 loop
    addr<=conv_std_logic_vector(j,4);
    donnee<=conv_std_logic_vector(j,f);
    wait for 40 ns;
     
   end loop;  -- j


   enable<='1';

   for w in 0 to 15 loop
     addr<=conv_std_logic_vector(w,4);
     wait for 40 ns;
   end loop;  -- w

  end process;
  
         
end simsram;
