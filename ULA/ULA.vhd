library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula is
  port( a, b        : in  std_logic_vector(3 downto 0);
        op          : in  std_logic_vector(1 downto 0);
        s           : out std_logic_vector(3 downto 0);
        z, overflow : out std_logic );
end ula;

architecture comportamento of ula is

  signal op_sel, cin_sel  : std_logic;
  signal b_mux, s_interno : std_logic_vector(3 downto 0);

  component four_bitAdder is
    port (a, b     : in  std_logic_vector(3 downto 0);
          s        : out std_logic_vector(3 downto 0);
          cin      : in  std_logic;
          overflow : out std_logic );
  end component;

begin

  op_sel  <= op(1) or (not op(0));

  cin_sel <= not op_sel;

  b_mux   <=     b when op_sel = '1' else
             not b when op_sel = '0';

  adder : four_bitAdder port map (a, b_mux, s_interno, cin_sel, overflow);

  z <= ( (s_interno(0) nand s_interno(1) ) nand s_interno(2) ) nand s_interno(3);
  s <= s_interno;

end comportamento;

