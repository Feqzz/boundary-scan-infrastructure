library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity OR_Cell is
    Port ( pin : in STD_LOGIC;
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sin : in STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           mlc : in STD_LOGIC;
           pout : out STD_LOGIC;
           enable_ir : in STD_LOGIC;
           sout : out STD_LOGIC
       );
end OR_Cell;
architecture Behavioral of OR_Cell is

signal mio, cs_nxt, cs_reg, l_nxt, l_reg : STD_LOGIC;

begin
-- state register
process(clk, rst)
begin
    if rst = '1' then
        cs_reg <= '0';
    elsif(rising_edge(clk))then
        cs_reg <= cs_nxt;
    end if;
end process;

process(clk, rst)
begin
    if rst = '1' then
        l_reg <= '0';
    elsif(falling_edge(clk)) then
        l_reg <= l_nxt;
    end if;
end process;

--mux_in
mio <= pin when mic = '0' else
       sin;

--mux_cs
cs_nxt <= mio when (mcsc = '1' and enable_ir = '1') else
        cs_reg;

--mux_l
l_nxt <= cs_reg when (mlc = '1' and enable_ir = '1') else
         l_reg;

pout <= l_reg;
sout <= cs_reg;
end Behavioral;