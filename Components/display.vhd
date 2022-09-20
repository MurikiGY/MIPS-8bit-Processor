library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display is
  port(
    clk_fpga   : in  std_logic;
    reg_values : in  std_logic_vector(15 downto 0);
    anodes     : out std_logic_vector(3 downto 0);
    cathodes   : out std_logic_vector(7 downto 0) 
  );
end display;

architecture comportamento of display is

  signal reg         : std_logic_vector(3 downto 0); 

  signal clk_counter : natural range 0 to 100000 := 0;
  signal an_number   : natural range 0 to 4      := 0;

begin

  process(clk_fpga)
  begin
    --Divide o clock
    if clk_fpga'event and clk_fpga = '1' then
	   clk_counter <= clk_counter + 1;
		if clk_counter >= 100000 then
		  clk_counter <= 0;
        
		  --Atualiza o an_number em sequncia 
        an_number <= an_number + 1;
        if an_number > 3 then
          an_number <= 0;
			 
		  end if; --an_number  
		end if; --clk_counter
    end if; --clk_fpga
	 
  end process;
  
  process(an_number, reg_values)
  begin
    --Define qual digito do display mostrar
    case an_number is
	   when 0 => anodes <= "1110";
		when 1 => anodes <= "1101";
		when 2 => anodes <= "1011";
		when 3 => anodes <= "0111";
		
		when others => anodes <= "1111"; --Desliga os displays
    end case;
	 
	 --Define o dado de n a ser mostrado
    case an_number is
	   when 0 => reg <= reg_values(3  downto 0);
		when 1 => reg <= reg_values(7  downto 4);
		when 2 => reg <= reg_values(11 downto 8);
		when 3 => reg <= reg_values(15 downto 12);
		
		when others => reg <= "0000";
    end case; 
  end process;

  process(reg)
  begin
    case reg is
      when "0000" => cathodes <= "11000000"; -- 0
      when "0001" => cathodes <= "11111001"; -- 1
      when "0010" => cathodes <= "10100100"; -- 2
      when "0011" => cathodes <= "10110000"; -- 3
      when "0100" => cathodes <= "10011001"; -- 4
      when "0101" => cathodes <= "10010010"; -- 5
      when "0110" => cathodes <= "10000010"; -- 6
      when "0111" => cathodes <= "11111000"; -- 7    
            
      when "1111" => cathodes <= "01111001"; -- -1
		when "1110" => cathodes <= "00100100"; -- -2
		when "1101" => cathodes <= "00110000"; -- -3
		when "1100" => cathodes <= "00011001"; -- -4
		when "1011" => cathodes <= "00010010"; -- -5
		when "1010" => cathodes <= "00000010"; -- -6
		when "1001" => cathodes <= "01111000"; -- -7
		when "1000" => cathodes <= "00000000"; -- -8

      when others => cathodes <= "11111111"; --desliga
    end case;
  end process;

end comportamento;
