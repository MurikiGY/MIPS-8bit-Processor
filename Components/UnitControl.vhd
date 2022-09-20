library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity UnitControl is
   port (
      OP       : in  std_logic_vector (1 downto 0);
      RegWr    : out std_logic;
      Immediate: out std_logic;
      Bne      : out std_logic;
      MemWr    : out std_logic;
      MemRead  : out std_logic;
      ALUOP    : out std_logic 
   );
end UnitControl;

architecture Behavior of UnitControl is

   signal o, p : std_logic;

begin

   o <= OP(1);
   p <= OP(0);

   Immediate  <= o;
   MemRead    <= ( o and not p );
   Bne        <= ( not o and p );
   MemWr      <= ( o and p );
   RegWr      <= ( not p );
   ALUOP      <= ( not o and p );

end Behavior;
