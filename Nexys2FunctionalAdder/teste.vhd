library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_bitAdder is
  port( a, b     : in  std_logic_vector (3 downto 0);
        overflow  : out std_logic;
        anodes   : out std_logic_vector (3 downto 0);
        cathodes : out std_logic_vector (7 downto 0) );
end four_bitAdder;

architecture comportamento of four_bitAdder is


  signal cout : std_logic_vector(3 downto 0);
  signal s    : std_logic_vector (3 downto 0);

  component display is
    port( n         : in  std_logic_vector (3 downto 0);
			 anodes    : out std_logic_vector (3 downto 0);
          cathodes  : out std_logic_vector (7 downto 0) );
  end component;
  
  component fullAdder is
    port( a, b, cin : in std_logic;
		    s, cout   : out std_logic );
  end component;


begin

	s0 : fullAdder port map( a(0), b(0), '0', s(0), cout(0) );
	s1 : fullAdder port map( a(1), b(1), cout(0), s(1), cout(1) );
	s2 : fullAdder port map( a(2), b(2), cout(1), s(2), cout(2) );
	s3 : fullAdder port map( a(3), b(3), cout(2), s(3), cout(3) );

	overflow <= cout(2) xor cout(3);
	
	disp : display port map( s, anodes, cathodes);

end comportamento;