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
  signal clk     : std_logic;
  signal reset   : std_logic;
  signal temp_in : integer range 0 to 2**input_bit_width - 1;
  signal cs      : std_logic;
  signal pwm_out : std_logic; 

  -- clock
  signal Clk : std_logic := '1';

begin  -- stimuli

  -- component instantiation
  DUT: controller
    generic map (
      input_bit_width => input_bit_width)
    port map (
      clk     => clk,
      reset   => reset,
      temp_in => temp_in,
      cs      => cs,
      pwm_out => pwm_out);

  -- clock generation
  Clk <= not Clk after 10 ns;

  -- waveform generation
  WaveGen_Proc: process
  begin
    -- insert signal assignments here

    wait until Clk = '1';
  end process WaveGen_Proc;

  

end stimuli;

-------------------------------------------------------------------------------

configuration controller_tb_stimuli_cfg of controller_tb is
  for stimuli
  end for;
end controller_tb_stimuli_cfg;

-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------

entity controller_tb is

end controller_tb;

-------------------------------------------------------------------------------