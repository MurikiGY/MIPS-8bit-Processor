library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity micow is
  port(
    clk_fpga : in  std_logic;
    anodes   : out std_logic_vector(3 downto 0);
    cathodes : out std_logic_vector(7 downto 0)
  );
end micow;

architecture Behavior of micow is

  component pc
    port(
      clk    : in  std_logic;
		soma   : in  std_logic_vector(3 downto 0);
      prox   : in  std_logic_vector(3 downto 0);
      atual  : out std_logic_vector(3 downto 0)
    );
  end component;

  component MemRom
    port(
      addr : in  std_logic_vector(3 downto 0);
      data : out std_logic_vector(7 downto 0)
    );
  end component;

  component BankRegister
    port (
      clk            :  in  std_logic;
      clk_fpga       :  in std_logic;		
      reg_write      :  in  std_logic;                     
      in_rs, in_rt   :  in  std_logic_vector(1 downto 0); 
      reg_address    :  in  std_logic_vector(1 downto 0); 
      data           :  in  std_logic_vector(3 downto 0);
      out_rs, out_rt :  out std_logic_vector(3 downto 0);
		anodes         :  out std_logic_vector(3 downto 0);
      cathodes       :  out std_logic_vector(7 downto 0)
    );
  end component;

  component ula
    port( 
      a, b        : in  std_logic_vector(3 downto 0); 
      op          : in  std_logic;  
      s           : out std_logic_vector(3 downto 0);
      z           : out std_logic
    );
  end component;

  component MemRam
    port(
      clk         :  in  std_logic; 
      mem_read    :  in  std_logic;
      mem_write   :  in  std_logic; 
      mem_address :  in  std_logic_vector(3 downto 0);
      data_in     :  in  std_logic_vector(3 downto 0);  
      data_out    :  out std_logic_vector(3 downto 0)   
    );
  end component;

  component UnitControl
    port (
      OP       : in  std_logic_vector (1 downto 0);
		RegWr    : out std_logic;
      Immediate: out std_logic;
      Bne      : out std_logic;
      MemWr    : out std_logic;
      MemRead  : out std_logic;
      ALUOP    : out std_logic
    );
  end component;

  component clockDiv
    port(
      clk_in : in  std_logic;
      clk    : out std_logic
    );
  end component;
   
  signal clk, reg_wr, zero                   : std_logic;
  signal aluop, mem_rd, mem_wr, imm, bne     : std_logic;
  signal desvia                              : std_logic;
  signal rs_in, rt_in, op                    : std_logic_vector(1 downto 0);
  signal reg_addrs, rd_in                    : std_logic_vector(1 downto 0);
  signal pc_prox, pc_atual, data_rb          : std_logic_vector(3 downto 0);
  signal rs_out, rt_out, rg_ula, alu_result  : std_logic_vector(3 downto 0);
  signal mem_out, pc_soma                    : std_logic_vector(3 downto 0);
  signal instruction                         : std_logic_vector(7 downto 0);

begin

  rd_in     <= instruction(1 downto 0);
  rt_in     <= instruction(3 downto 2);
  rs_in     <= instruction(5 downto 4);
  op        <= instruction(7 downto 6);
  pc_atual   <= pc_prox;

  --Registrador de escrita eh o rt quando eh lw, se nao eh o rd
  Mux_rb:    reg_addrs  <= rt_in      when mem_rd = '1' else
								   rd_in;
							
  --Seleciona o imediato ao inves do rt para a ula
  Mux_ULA:   rg_ula     <= rt_out         when imm = '0' else
                           bne&bne&rd_in  when imm = '1';
  
  --Seleciona qual dado guardar no banco de registradores, a saida da ula ou da memoria
  Mux_dm:    data_rb    <= mem_out    when mem_rd = '1' else
							     alu_result;
  
  --Seleciona se soma pc+1 ou pc+desvio
  desvia <= bne and  not zero;
  Mux_desvia: pc_soma <= "11" & not rd_in when desvia = '1' else
                         "0001";

  --!!!!!!Sao 16 instuoes daria pra fazer um contador para parar a execucao!!!!!!!!
  clock:    clockDiv       port map (clk_fpga, clk);
  
  PCount:   pc             port map (clk, pc_soma, pc_atual, pc_prox);
  
  IM:       MemRom         port map (pc_atual, instruction);     
  
  RB:       BankRegister   port map (clk, clk_fpga, reg_wr, rs_in, rt_in, reg_addrs, data_rb, rs_out, rt_out, anodes, cathodes); 
  
  ALU:      ULA            port map (rs_out, rg_ula, aluop, alu_result, zero);
  
  DM:       MemRam         port map (clk, mem_rd, mem_wr, alu_result, rt_out, mem_out); 
  
  UControl: UnitControl    port map (op, reg_wr, imm, bne, mem_wr, mem_rd, aluop);

end Behavior;
