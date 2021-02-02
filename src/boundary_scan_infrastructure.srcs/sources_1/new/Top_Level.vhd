library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Top_Level is
    Port ( pin : in STD_LOGIC_VECTOR (3 downto 0);
           pout : out STD_LOGIC;
           tdo : out STD_LOGIC;
           tdi : in STD_LOGIC;
           tms : in STD_LOGIC;
           tck : in STD_LOGIC);
end Top_Level;

architecture Behavioral of Top_Level is

signal internal_rst, tap_mux_signal, ir_decoder_mux_signal,
data_mux_tdo, ir_tdo, bp_tdo, bs_reg_tdo, bs_moc, internal_core_logic_out,
ir_mic, ir_mcsc, ir_mlc, bs_mic, bs_mcsc, bs_mlc, bp_reg_mic : STD_LOGIC;

signal instruction_register_pout, internal_core_logic_in: STD_LOGIC_VECTOR (3 downto 0);

begin

tdo <= ir_tdo when tap_mux_signal = '1' else
    data_mux_tdo;

data_mux_tdo <= bp_tdo when ir_decoder_mux_signal = '1' else
    bs_reg_tdo;

tap_controller: entity work.TAP_Controller(Behavioral)
port map (tms => tms, clk => tck, rst_to_others => internal_rst, ir_mic => ir_mic, ir_mcsc => ir_mcsc, ir_mlc => ir_mlc,
bs_mic => bs_mic, bs_mcsc => bs_mcsc, bs_mlc => bs_mlc, data_instruction_mux_controller_signal => tap_mux_signal, bp_reg_mic => bp_reg_mic);

instruction_register: entity work.IR_Register(Behavioral)
port map (pout => instruction_register_pout, tdi => tdi, tdo => ir_tdo, mic => ir_mic, mcsc => ir_mcsc, rst => internal_rst, clk => tck, mlc => ir_mlc);

instruction_decoder: entity work.IR_Decoder(Behavioral)
port map (instruction => instruction_register_pout, data_mux => ir_decoder_mux_signal, bs_moc => bs_moc);

bp_cell: entity work.BP_Cell(Behavioral)
port map (clk => tck, rst => internal_rst, sin => tdi, sout => bp_tdo, bp_reg_mic => bp_reg_mic);

core_logic: entity work.Core_Logic(Behavioral)
port map (core_logic_in => internal_core_logic_in, core_logic_out => internal_core_logic_out);

bs_reg: entity work.BS_Register(Behavioral)
port map (tdi => tdi, pin => pin, core_logic_in => internal_core_logic_in, core_logic_out => internal_core_logic_out,
pout => pout, clk => tck, mic => bs_mic, moc => bs_moc, mcsc => bs_mcsc, mlc => bs_mlc, rst => internal_rst, tdo => bs_reg_tdo);

end Behavioral;