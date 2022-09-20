--No esquecer de ver o que fazer com o overflow
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bitAdder is
  port(
    c_in      : in    std_logic;
    a, b      : in    std_logic_vector (3 downto 0);
    s         : out   std_logic_vector (3 downto 0)
  );
end four_bitAdder;

architecture Behavior of four_bitAdder is

  signal cout,s_tmp   : std_logic_vector (3 downto 0);

  component fullAdder is
  port(
    a, b, cin   : in    std_logic;
    s, cout     : out   std_logic
  );
  end component;

begin

	s0 : fullAdder port map( a(0), b(0), c_in   , s_tmp(0), cout(0) );
	s1 : fullAdder port map( a(1), b(1), cout(0), s_tmp(1), cout(1) );
	s2 : fullAdder port map( a(2), b(2), cout(1), s_tmp(2), cout(2) );
	s3 : fullAdder port map( a(3), b(3), cout(2), s_tmp(3), cout(3) );

	s <= s_tmp;
	
end Behavior;
