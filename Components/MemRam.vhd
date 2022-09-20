library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MemRam is
   port(
      clk         :  in  std_logic;                    --clock
      mem_read    :  in  std_logic;                    --Sinal de leitura da memoria
      mem_write   :  in  std_logic;                    --Sinal de escrita na memoria
      mem_address :  in  std_logic_vector(3 downto 0); --Endereco de escrita na memoria
      data_in     :  in  std_logic_vector(3 downto 0); --Dado a ser escrito
      data_out    :  out std_logic_vector(3 downto 0)  --Dado lido
   );
end MemRam;

architecture Behavior of MemRam is

   --Memoria de 16 linhas com palavras de 4 bits
   type data_array is array (0 to 15) of std_logic_vector (3 downto 0);

   --Inicializacao da memoria
   signal data_mem: data_array := (
      "0001", --1
      "0000", --0
      "0111", --7
      "0111", --7
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000",
      "0000"
   );
  
begin
 
   --Saida de dados
   data_out <= data_mem(to_integer(unsigned(mem_address))) when mem_read = '1' else "0000";

   --Escrita na memoria
   process(mem_address, data_mem, clk, mem_write)
   begin

      if clk'event and clk = '0' and mem_write = '1' then
         data_mem(to_integer(unsigned(mem_address))) <= data_in;
      end if;
     
   end process;

end Behavior;