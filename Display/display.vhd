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
            when "0110" => cathodes <= "10000010"; -- 6
            when "0111" => cathodes <= "11111000"; -- 7
				
			when "1000" => cathodes <= "01111001"; -- -1
            when "1001" => cathodes <= "00100100"; -- -2
            when "1010" => cathodes <= "00110000"; -- -3
            when "1011" => cathodes <= "00011001"; -- -4
            when "1100" => cathodes <= "00010010"; -- -5
            when "1101" => cathodes <= "00000010"; -- -6
            when "1110" => cathodes <= "01111000"; -- -7
            when "1111" => cathodes <= "00000000"; -- -8

            when others => cathodes <= "11111111"; --desliga
        end case;
    end process;

    anodes <= "0000";

end comportamento;

