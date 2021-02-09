library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_Level_tb is
    --  Port ( );
    end Top_Level_tb;

architecture Behavioral of Top_Level_tb is

    component Top_Level
        Port ( pin : in STD_LOGIC_VECTOR (3 downto 0);
               pout : out STD_LOGIC;
               tdo : out STD_LOGIC;
               tdi : in STD_LOGIC;
               tms : in STD_LOGIC;
               tck : in STD_LOGIC);
    end component;

    signal pin : STD_LOGIC_VECTOR (3 downto 0);
    signal pout_tb, tdo_tb, tdi, tms, tck_tb : STD_LOGIC;
    constant clk_period : time := 4 ns;

begin

    UUT: Top_Level
    port map (pin => pin, pout => pout_tb, tdo => tdo_tb, tdi => tdi, tms => tms, tck => tck_tb);

    process
    begin
        tck_tb <= '0';
        wait for (clk_period / 2);
        tck_tb <= '1';
        wait for (clk_period / 2);
    end process;

    process
    begin

        pin <= "1111";
        tms <= '1';				
        wait for clk_period;	-- Go to TLR
        tms <= '0';				
        wait for clk_period;		-- Go to RTI
        tms <= '1';		
        wait for clk_period;		-- Go to SEL-DR
        tms <= '1';		
        wait for clk_period;		-- Go to SEL-IR
        tms <= '0';	
        wait for clk_period;		-- Go to CAPT-IR
        tms <= '0';		
        tdi <= '0';
        wait for clk_period;		-- Go to SHIFT-IR
                              -- To shift in the EXTEST instruction
        wait for clk_period*3;	-- Remain in SHIFT-IR for 3 TCK cycles
        tms <= '1';		
        wait for clk_period;		-- Shift last bit into IR and go to EX1-IR
        tms <= '1';		
        wait for clk_period;		-- Go to UPDT-IR
        tms <= '1';		
        wait for clk_period;		-- Go to SEL-DR
        tms <= '0';		
        wait for clk_period;		-- Go to CAPT-DR
        tms <= '0';
        tdi <= '1';		
        wait for clk_period*2;		-- Go to SHIFT-DR
        tdi <= '0';
        tms <= '0';		
        wait for clk_period*3;	-- Remain in SHIFT-DR for 4 TCK cycles
        tms <= '1';	
        wait for clk_period;	
        wait for clk_period;
        -- Shift last bit into DR (BSR) and go to EX1-DR
        tms <= '0';		
        pin <= "0101";
        wait for clk_period*5;		-- Go to UPDT-DR




        --TEST FROM DATASHEET
        --        pin <= "0010";
        --        tdi <= '1';
        --        tms <= '1';				
        --        wait for clk_period;	-- Go to TLR
        --        tms <= '0';				
        --        wait for clk_period;		-- Go to RTI
        --        tms <= '1';		
        --        wait for clk_period;		-- Go to SEL-DR
        --        tms <= '1';		
        --        wait for clk_period;		-- Go to SEL-IR
        --        tms <= '0';		
        --        wait for clk_period;		-- Go to CAPT-IR
        --        tms <= '0';		
        --        wait for clk_period;		-- Go to SHIFT-IR
        --			                         -- To shift in the EXTEST instruction
        --        wait for clk_period*3;	-- Remain in SHIFT-IR for 3 TCK cycles
        --        tms <= '1';		
        --        wait for clk_period;		-- Shift last bit into IR and go to EX1-IR
        --        tms <= '1';		
        --        wait for clk_period;		-- Go to UPDT-IR
        --        tms <= '1';		
        --        wait for clk_period;		-- Go to SEL-DR
        --        tms <= '0';		
        --        wait for clk_period;		-- Go to CAPT-DR
        --        tms <= '0';		
        --        wait for clk_period*2;		-- Go to SHIFT-DR
        --        tdi <= '0';
        --        tms <= '0';		
        --        wait for clk_period;	-- Remain in SHIFT-DR for 4 TCK cycles
        --        tdi <= '1';
        --        tms <= '1';	
        --        wait for clk_period;	
        --        wait for clk_period;
        --		-- Shift last bit into DR (BSR) and go to EX1-DR
        --        tms <= '1';		
        --        wait for clk_period*5;		-- Go to UPDT-DR


        wait;




        wait;
    end process;


end Behavioral;
