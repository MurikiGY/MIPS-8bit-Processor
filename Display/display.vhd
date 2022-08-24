library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
  port( n        : in  std_logic_vector (3 downto 0);
        anodes   : out std_logic_vector (3 downto 0);
        cathodes : out std_logic_vector (7 downto 0) );
end display;

architecture comportamento of display is

begin

    process(n)
    begin
        case n is
            when "0000" => cathodes <= "11000000"; -- 0
            when "0001" => cathodes <= "11111001"; -- 1
            when "0010" => cathodes <= "10100100"; -- 2
            when "0011" => cathodes <= "10110000"; -- 3
            when "0100" => cathodes <= "10011001"; -- 4
            when "0101" => cathodes <= "10010010"; -- 5
            when "0110" => cathodes <= "10000011"; -- 6
            when "0111" => cathodes <= "11111000"; -- 7

            when "1000" => cathodes <= "10001001"; -- -8 H
            when "1001" => cathodes <= "10010100"; -- -7 G
            when "1010" => cathodes <= "10001110"; -- -6 F
            when "1011" => cathodes <= "10000110"; -- -5 E
            when "1100" => cathodes <= "10100001"; -- -4 d
            when "1101" => cathodes <= "11000110"; -- -3 C
            when "1110" => cathodes <= "10010011"; -- -2 b
            when "1111" => cathodes <= "10001000"; -- -1 A

            when others => cathodes <= "11111111"; --desliga
        end case;
    end process;

    anodes <= "1110";

end comportamento;
