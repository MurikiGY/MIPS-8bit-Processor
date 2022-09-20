library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MemRom is
   port(
      addr : in  std_logic_vector(3 downto 0);
      data : out std_logic_vector(7 downto 0)
   );
end MemRom;

architecture Behavior of MemRom is
   
	type mem_t is array (0 to 15) of std_logic_vector(7 downto 0);
  
   constant mem : mem_t := (
   --Adicione as instrues aqui
   
   --Configuracao inicial
   
   --Mem[0..3] = 1 0 7 7
   --Reg[0..3] = 0 1 5 5
   
   --Inicia o programa, garante o loop das instruoes
   "10000100", --lw $1, 0(S0)    ($1 = 1)
   "10001001", --lw $2, 1($0)    ($2 = 0)
   "10001111", --lw $3, 3($0)    ($3 = 7)
   "11001111", --sw $3, 3($0)    (Mem=3] = 7)
    
   --Mem[0..3] = 1 0 7 7
   --Reg[0..3] = 0 1 0 7
   
   --$2 conta ate 7
   "00100110", --add $2, $2, $1 ($2++)
   "01111000", --bne $3, $2, 0  ($3 != $2? Se sim, volta 1 instrucao)
   
   --Mem[0..3] = 1 0 7 7
   --Reg[0..3] = 0 1 7 7
  
   --Altera alguns valores para o proximo loop
   "00011111", --add $3, $1, $3 ($3 = -8)
   "11001110", --sw $3, 2($0)   (Mem[2] = -8)
   "11001011", --sw $2, 3($0)   (Mem[3] = 7)
   "10001101", --lw $3, 1($0)   ($3 = 0)
     
   --Mem[0..3] = 1 0 -8 7
   --Reg[0..3] = 0 1 7 0
   
   --$3 conta ate -8, $2 alterna entre 0 e -8
   "10001010", --lw $2, 2($0)   ($2 = -8)
   "00110111", --add $3, $3, $1 ($3++)
   "00000010", --add $2, $0, $0 ($2 = 2)
   "10001010", -- lw $2, 2($0)  ($2 = -8)
   "01111011", --bne $3, $2, 3  ($3 != $2? Se sim, volta 4 instrues)
  
   --Mem[0..3] = 1 0 -8 7
   --Reg[0..3] = 0 1 -8 -8
  
   --$1 recebe -8 para marcar o fim de um ciclo do PC
   "10000110"  --lw $1, 2($0)   $1 = -8)
   
   --Mem[0..3] = 1 0 -8 7
   --Reg[0..3] = 0 -8 -8 -8
   
   );

begin

   data <= mem(to_integer(unsigned(addr)));
  
end Behavior;
