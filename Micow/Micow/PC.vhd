library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pc is
   port(
      clk    : in  std_logic;
      soma   : in  std_logic_vector(3 downto 0);
      prox   : in  std_logic_vector(3 downto 0);
      atual  : out std_logic_vector(3 downto 0)
   );
end pc;

architecture Behavior of pc is

   signal address: std_logic_vector(3 downto 0) := "0000";

begin

   atual <= address;

   --Atualiza Program Counter na bora de subida
   process(clk, prox, soma)
   begin
  
      if clk'event and clk = '1' then
         address <= prox + soma;
      end if;

   end process;

end Behavior;
	 

