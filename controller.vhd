library ieee;
use ieee.std_logic_1164.all;

entity controller is
  
  generic (
    input_bit_width : integer := 10);   -- bit width from ADC input

  port (
    clk     : in  std_logic;            -- system clock
    reset   : in  std_logic;            -- reset
    temp_in : in  integer range 0 to 2**input_bit_width - 1;  -- measured temperature from ADC
    cs      : out std_logic;            -- chip select signal to start
                                        -- conversion by ADC
    pwm_out : out std_logic);           -- pwm signal for motor control

end controller;

architecture behave of controller is
  signal pwm_cnt_on_sig  : integer range 0 to 2**input_bit_width - 1 := 4999;
  signal pwm_clk_cnt_sig : integer range 0 to 2**input_bit_width - 1 := 0;
  signal pwm_out_sig     : std_logic;
  signal cs_sig : std_logic;            -- internal signal for chip select

begin  -- behave

  pwm_generation : process (clk, reset)
  begin  -- process pwm_generation
    if reset = '1' then
      pwm_out_sig     <= '0';
      cs_sig <= '0';
      pwm_clk_cnt_sig <= 0;
      pwm_cnt_on_sig  <= 4999;
    elsif rising_edge(clk) then
      if pwm_clk_cnt_sig = 9999 then
        pwm_clk_cnt_sig <= 0;
        pwm_out_sig     <= '1';
      elsif pwm_clk_cnt_sig = pwm_cnt_on_sig then
        pwm_clk_cnt_sig <= pwm_clk_cnt_sig + 1;
        pwm_out_sig     <= '0';
      end if;
    end if;
  end process pwm_generation;

  pwm_out <= pwm_out_sig;
  cs <= not cs_sig;
  
end behave;
