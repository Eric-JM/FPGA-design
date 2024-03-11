-------------------------------------------------------------------------------
-- Title      : SRAM
-- Project    : 
-------------------------------------------------------------------------------
-- File       : sram.vhd
-- Author     :  E J M
-- Company    : 
-- Last update: 2015/09/24
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: SRAM model
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2015/07/11  1.0      QV      Created
-------------------------------------------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity sram is
  generic (
    N                   :     integer := 16);
  port (data            : in  std_logic_vector(N-1 downto 0);
        q               : out std_logic_vector(N-1 downto 0);
        address         : in  std_logic_vector(3 downto 0);
        clk, reset, WEN : in  std_logic);

end sram;

architecture a_sram of sram is

  type stock is array (0 to 15) of std_logic_vector(N-1 downto 0);


begin  -- a_sram


  mem            : process(clk, reset, WEN, address, data)
    variable ram : stock;

  begin
    if clk'event and clk = '1' then


      if reset = '1' then

        for k in 0 to 15
        loop
          ram(k) := (others => '0');
        end loop;  -- i

      elsif WEN = '0' then
        ram(conv_integer(address)) := data;


      elsif WEN = '1' then
        q <= ram(conv_integer(address)) after 6 ns;




      end if;


    end if;
    
  end process;
end a_sram;


