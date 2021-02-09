library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TAP_Controller is
    Port ( tms : in STD_LOGIC;
           clk : in STD_LOGIC;
           bs_mic : out STD_LOGIC;
           bs_mcsc : out STD_LOGIC;
           bs_mlc : out STD_LOGIC;
           ir_mic : out STD_LOGIC;
           ir_mcsc : out STD_LOGIC;
           ir_mlc : out STD_LOGIC;
           bp_reg_mic : out STD_LOGIC;
           bp_reg_mcsc : out STD_LOGIC;
           data_instruction_mux_controller_signal : out STD_LOGIC;
           rst_to_others : out STD_LOGIC);
end TAP_Controller;

architecture Behavioral of TAP_Controller is

type FSM is (TLR, RTI, SDRS, CDR, SDR, E1DR, PDR, E2DR, UDR, SIRS, CIR, SIR, E1IR, PIR, E2IR, UIR);
signal state_reg, state_next : FSM;

begin

process (clk)
begin
	if rising_edge(clk) then
		state_reg <= state_next;
	end if;
end process;

process (state_reg, tms)
begin
    state_next <= state_reg;
    rst_to_others <= '0';
    bs_mic <= '0';
    bs_mcsc <= '0';
    bs_mlc <= '0';
    ir_mic <= '0';
    ir_mcsc <= '0';
    ir_mlc <= '0';
    bp_reg_mcsc <= '0';
    data_instruction_mux_controller_signal <= '0';
    bp_reg_mic <= '0';
    case state_reg is
        when TLR =>
            rst_to_others <= '1';
            if tms = '0' then
                state_next <= RTI;
            end if;
        when RTI =>
            
            if tms = '1' then
                state_next <= SDRS;
            end if;
        when SDRS =>
            if tms = '1' then
                state_next <= SIRS;
            else
                state_next <= CDR;
            end if;
        when CDR => 
            bp_reg_mcsc <= '1';           
            bs_mic <= '0';
            bs_mcsc <= '1';
            bs_mlc <= '0';
            if tms = '1' then
                state_next <= E1DR;
            else
                state_next <= SDR;
            end if;
        when SDR =>
            bp_reg_mic <= '1';
            bp_reg_mcsc <= '1';
            bs_mic <= '1';
            bs_mcsc <= '1';
            bs_mlc <= '0';
            if tms = '1' then
                state_next <= E1DR;
            end if;
         when E1DR =>
            --bs_mic <= '0';
            bs_mcsc <= '0';
            bs_mlc <= '0';
            if tms = '1' then
                state_next <= UDR;
            else
                state_next <= PDR;
            end if;
        when PDR =>
            --bs_mic <= '0';
            bs_mcsc <= '0';
            bs_mlc <= '0';
            if tms = '1' then
                state_next <= E2DR;
            end if;
        when E2DR =>
            --bs_mic <= '0';
            bs_mcsc <= '0';
            bs_mlc <= '0';
            if tms = '1' then
                state_next <= UDR;
            else
                state_next <= SDR;
            end if;
        when UDR =>
            --bs_mic <= '0';
            --bs_mcsc <= '1';
            bs_mlc <= '1';
            if tms = '1' then
                state_next <= SDRS;
            else
                state_next <= RTI;
            end if;
       when SIRS =>
            if tms = '1' then
                state_next <= TLR;
            else
                state_next <= CIR;
            end if;
        when CIR =>
            ir_mic <= '0';
            ir_mcsc <= '1';
            ir_mlc <= '0';
            if tms = '1' then
                state_next <= E1IR;
            else
                state_next <= SIR;
            end if;
        when SIR =>
            data_instruction_mux_controller_signal <= '1';
            ir_mic <= '1';
            ir_mcsc <= '1';
            ir_mlc <= '0';
            if tms = '1' then
                state_next <= E1IR;
            end if;
         when E1IR =>
            --ir_mic <= '0';
            ir_mcsc <= '0';
            ir_mlc <= '0';
            if tms = '1' then
                state_next <= UIR;
            else
                state_next <= PIR;
            end if;
        when PIR =>
            --ir_mic <= '0';
            ir_mcsc <= '0';
            ir_mlc <= '0';
            if tms = '1' then
                state_next <= E2IR;
            end if;
        when E2IR =>
            --ir_mic <= '0';
            ir_mcsc <= '0';
            ir_mlc <= '0';
            if tms = '1' then
                state_next <= UIR;
            else
                state_next <= SIR;
            end if;
        when UIR =>
            --ir_mic <= '0';
            --ir_mcsc <= '0'; 
            ir_mlc <= '1';
            if tms = '1' then
                state_next <= SDRS;
            else
                state_next <= RTI;
            end if;
    end case;

end process;

end Behavioral;
