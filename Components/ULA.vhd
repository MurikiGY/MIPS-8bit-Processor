
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula is
   port( 
     a, b        : in  std_logic_vector(3 downto 0); 
     op          : in  std_logic; 
     s           : out std_logic_vector(3 downto 0); 
     z           : out std_logic
   );
end ula;

architecture comportamento of ula is

   signal b_mux, s_interno : std_logic_vector(3 downto 0);

   component four_bitAdder is
     port (
	    c_in    : in  std_logic;
	    a, b    : in  std_logic_vector(3 downto 0);
       s       : out std_logic_vector(3 downto 0)
     );
   end component;

begin
  
  b_mux <=     b when op = '0' else
           not b when op = '1';

  adder : four_bitAdder port map (op, a, b_mux, s_interno);
  
  z <= (not s_interno(0)) and (not s_interno(1)) and (not s_interno(2)) and (not s_interno(3));
  s <= s_interno;
  
end comportamento;
