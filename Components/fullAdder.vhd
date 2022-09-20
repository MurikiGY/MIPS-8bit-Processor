library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fullAdder is
   port(
      a, b, cin   : in    std_logic;
      s, cout     : out   std_logic
   );
end fullAdder;

architecture comportamento of fullAdder is

   signal c, d, e  : std_logic;

begin
   c    <= a xor b;
   d    <= c and cin;
   e    <= a and b;
  
   s    <= c xor cin;
   cout <= d or  e;

end comportamento;
