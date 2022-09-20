library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BankRegister is
   port (
      clk            :  in  std_logic;                   --Clock reduzido
      clk_fpga       :  in  std_logic;                   --Clock do fpga
	   reg_write      :  in  std_logic;                   --Habilitao de escrita
      in_rs, in_rt   :  in  std_logic_vector(1 downto 0);--Seletores da sada
      reg_address    :  in  std_logic_vector(1 downto 0);--Seletor do registrador a ser escrito
      data           :  in  std_logic_vector(3 downto 0);--Dado a ser escrito
      out_rs, out_rt :  out std_logic_vector(3 downto 0);--Dado de sada
	   anodes         :  out std_logic_vector(3 downto 0);
      cathodes       :  out std_logic_vector(7 downto 0) 
   );
end BankRegister;

architecture Behavior of BankRegister is

   -- 4 registradores de palavra de 4 bits
   type mem_array is array(0 to 3) of std_logic_vector (3 downto 0);
   signal reg_mem: mem_array := (
      "0000", --0
      "0001", --1
      "0101", --5
      "0101"  --5
   );
  
   component display
      port(
         clk_fpga   : in  std_logic;	 
         reg_values : in  std_logic_vector(15 downto 0);
         anodes     : out std_logic_vector(3 downto 0);
         cathodes   : out std_logic_vector(7 downto 0) 
	   );
   end component;
  
   signal reg_values : std_logic_vector(15 downto 0);

begin

   --Dados de sada do registrador
   out_rs <= reg_mem(to_integer(unsigned(in_rs)));
   out_rt <= reg_mem(to_integer(unsigned(in_rt)));

   process(clk, reg_write)
   begin

      --Escreve no banco de registradores
      if clk'event and clk = '1' then
         if reg_write = '1' then
            reg_mem(to_integer(unsigned(reg_address))) <= data;
	      end if;
      end if;
	 
   end process; 
	 
   --Cria um vetor com os valores nos registradores
   process(reg_mem)
   begin
      reg_values <= reg_mem(3) & reg_mem(2) & reg_mem(1) & reg_mem(0); 
   end process;
	
   display0: display port map (clk_fpga, reg_values, anodes, cathodes);

end Behavior;