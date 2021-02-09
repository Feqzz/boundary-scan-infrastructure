library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity IR_Cell is
    Port ( pin : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sin : in STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           mlc : in STD_LOGIC;
           pout : out STD_LOGIC;
           sout : out STD_LOGIC
       );
end IR_Cell;
architecture Behavioral of IR_Cell is

signal mio, cs_nxt, cs_reg, l_nxt, l_reg : STD_LOGIC;

begin
-- state register
process(clk,rst)
begin
    if rst='1' then
        cs_reg <= '0';
    elsif(rising_edge(clk))then
        cs_reg <= cs_nxt;
    end if;
end process;

process(clk,rst)
begin
    if rst='1' then
        l_reg <= '0';
    elsif(falling_edge(clk)) then
        l_reg <= l_nxt;
    end if;
end process;

--mux_in
mio <= pin when mic = '0' else
       sin;

--mux_cs
cs_nxt <= cs_reg when mcsc = '0' else
          mio;

--mux_l
l_nxt <= l_reg when mlc = '0' else
         cs_reg;

pout <= l_reg;
sout <= cs_reg;
end Behavioral;