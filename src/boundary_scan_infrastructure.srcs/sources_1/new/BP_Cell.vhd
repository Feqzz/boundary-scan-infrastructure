library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BP_Cell is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           sin : in STD_LOGIC;
           mic : in STD_LOGIC;
           mcsc : in STD_LOGIC;
           enable_ir : in STD_LOGIC;
           sout : out STD_LOGIC
       );
end BP_Cell;

architecture Behavioral of BP_Cell is

signal mio, cs_nxt, cs_reg : STD_LOGIC;

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

--mux_in
mio <= '0' when mic = '0' else
        sin;
--mux_cs
cs_nxt <= mio when (mcsc = '1' and enable_ir = '1')  else
          cs_reg;
                    
sout <= cs_reg;

end Behavioral;
