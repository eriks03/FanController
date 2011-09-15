-------------------------------------------------------------------------------
-- Title      : Testbench for design "controller"
-- Project    : FanController
-------------------------------------------------------------------------------
-- File       : controller_tb.vhd
-- Author     : Erik Schubert  <eriks@tu-chemnitz.eu>
-- Company    : 
-- Created    : 2011-09-15
-- Last update: 2011-09-15
-- Platform   : 
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: 
-------------------------------------------------------------------------------
-- Copyright (c) 2011 
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2011-09-15  1.0      eriks	Created
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity controller_tb is

end controller_tb;

-------------------------------------------------------------------------------

architecture stimuli of controller_tb is

  component controller
    generic (
      input_bit_width : integer); 
    port (
      clk     : in  std_logic;
      reset   : in  std_logic;
      temp_in : in  integer range 0 to 2**input_bit_width - 1;
      cs      : out std_logic;
      pwm_out : out std_logic); 
  end component;

  -- component generics
  constant input_bit_width : integer := 10; 

  -- component ports
  signal clk_sig     : std_logic := '1';
  signal reset   : std_logic;
  signal temp_in : integer range 0 to 2**input_bit_width - 1;
  signal cs      : std_logic;
  signal pwm_out : std_logic; 

begin  -- stimuli

  -- component instantiation
  DUT: controller
    generic map (
      input_bit_width => input_bit_width)
    port map (
      clk     => clk_sig,
      reset   => reset,
      temp_in => temp_in,
      cs      => cs,
      pwm_out => pwm_out);

  -- clock generation
  clk_sig <= not clk_sig after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here
    reset <= '1';
    wait for 30 ns;
    reset <= '0';
    wait;
   -- wait until Clk = '1';
  end process WaveGen_Proc;

  

end stimuli;

-------------------------------------------------------------------------------

configuration controller_tb_stimuli_cfg of controller_tb is
  for stimuli
  end for;
end controller_tb_stimuli_cfg;

-------------------------------------------------------------------------------
