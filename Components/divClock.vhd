library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity clockDiv is
   port(
      clk_in : in  std_logic;  --Clock de entrada FPGA
      clk    : out std_logic   --Clock de saida
   );
end clockDiv;

architecture Behavior of clockDiv is

   signal div: std_logic_vector(27 downto 0):=(others =>'0'); --28bits
   signal clk_tmp: std_logic := '0';

begin

   process(clk_in)
   begin

      if clk_in'event and clk_in = '1' then
         div <= div + x"0000001";

         if (div = x"2FAF080") then

            div <= x"0000000";
            clk_tmp <= not clk_tmp;

         end if;

         clk <= clk_tmp;

      end if;

   end process;

end Behavior;
