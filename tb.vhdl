library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test is
end test;

architecture behav of test is
  component insmem
    port (
      clk     : in std_logic;
      address : in std_logic_vector(31 downto 0);
      dataout : out std_logic_vector(31 downto 0);
      datain  : in std_logic_vector(31 downto 0);
      writeins: in std_logic
    );
  end component;
  component RegisterFile
    port(
      clk: in std_logic;
      read_reg_1: in std_logic_vector(4 downto 0);
      read_reg_2: in std_logic_vector(4 downto 0);
      write_reg: in std_logic_vector(4 downto 0);
      write_data: in std_logic_vector(31 downto 0);
      write_enable: in std_logic;
      read_data_1: out std_logic_vector(31 downto 0);
      read_data_2: out std_logic_vector(31 downto 0)
    );
  end component;
  component datamem
    port(
      clk: in std_logic;
      address: in std_logic_vector(31 downto 0);
      datain: in std_logic_vector(31 downto 0);
      write_enable: in std_logic;
      read_enable: in std_logic;
      dataout: out std_logic_vector(31 downto 0)
    );
  end component;
  component micomp
    port (
      clk     : in std_logic;
      startpc : in std_logic_vector(31 downto 0);
      insaddr : out std_logic_vector(31 downto 0);
      insdata : in std_logic_vector(31 downto 0);
      rf_read_reg_1: out std_logic_vector(4 downto 0);
      rf_read_reg_2: out std_logic_vector(4 downto 0);
      rf_write_reg: out std_logic_vector(4 downto 0);
      rf_write_data: out std_logic_vector(31 downto 0);
      rf_write_enable: out std_logic;
      rf_read_data_1: in std_logic_vector(31 downto 0);
      rf_read_data_2: in std_logic_vector(31 downto 0);
      dm_address: out std_logic_vector(31 downto 0);
      dm_datain: out std_logic_vector(31 downto 0);
      dm_write_enable: out std_logic;
      dm_dataout: in std_logic_vector(31 downto 0)
    );
  end component;
  component clock
    port (
      clk: out std_logic
    );
  end component;
  signal clk     : std_logic;
  signal ss : std_logic;
  signal startpc : std_logic_vector(31 downto 0);
  signal insaddr, insaddrmicomp: std_logic_vector(31 downto 0);
  signal insdata, insdatamicomp : std_logic_vector(31 downto 0);
  signal insdatain: std_logic_vector(31 downto 0);
  signal inswrite: std_logic;
  signal rf_read_reg_1: std_logic_vector(4 downto 0);
  signal rf_read_reg_2: std_logic_vector(4 downto 0);
  signal rf_write_reg, rf_write_reg_micomp: std_logic_vector(4 downto 0);
  signal rf_write_data, rf_write_data_micomp: std_logic_vector(31 downto 0);
  signal rf_write_enable, rf_write_enable_micomp: std_logic;
  signal rf_read_data_1: std_logic_vector(31 downto 0);
  signal rf_read_data_2: std_logic_vector(31 downto 0);
  signal dm_address: std_logic_vector(31 downto 0);
  signal dm_datain: std_logic_vector(31 downto 0);
  signal dm_write_enable: std_logic;
  signal dm_dataout: std_logic_vector(31 downto 0);
  signal writingreg: integer := 4;
  signal firstreg, secondreg: std_logic_vector(4 downto 0);
  signal firstdata, seconddata: std_logic_vector(31 downto 0);
  signal dummy:  std_logic_vector(31 downto 0);

begin

  clock_0: clock port map(clk);
  cpu: micomp port map(clk, startpc, insaddr, insdata, rf_read_reg_1, rf_read_reg_2, rf_write_reg_micomp, rf_write_data_micomp, rf_write_enable_micomp, rf_read_data_1, rf_read_data_2, dm_address, dm_datain,dm_write_enable, dm_dataout);
  im_0: insmem port map(clk, insaddr, insdata, insdatain, inswrite);
  regfile_0: RegisterFile port map(clk, rf_read_reg_1, rf_read_reg_2, rf_write_reg, rf_write_data, rf_write_enable, rf_read_data_1, rf_read_data_2);
  dm_0: datamem port map(clk, dm_address, dm_datain, dm_write_enable, '1', dm_dataout);

process
begin

  if writingreg = 0 then
    inswrite <= '0';
    rf_write_enable <= rf_write_enable_micomp;
    rf_write_reg <= rf_write_reg_micomp;
    rf_write_data <= rf_write_data_micomp;


  elsif writingreg = 1 then
    rf_write_enable <= rf_write_enable_micomp;
    rf_write_reg <= rf_write_reg_micomp;
    rf_write_data <= rf_write_data_micomp;
    writingreg <= 0;

    inswrite <= '1';
    insaddr <= std_logic_vector(to_unsigned(3, 32));
    insdatain <= "00000000000000000000000000000000";
    report "started" severity note;


  elsif writingreg = 2 then
    rf_write_enable <= rf_write_enable_micomp;
    rf_write_reg <= rf_write_reg_micomp;
    rf_write_data <= rf_write_data_micomp;
    writingreg <= 1;

    inswrite <= '1';
    insaddr <= std_logic_vector(to_unsigned(2, 32));
    insdatain <= "00011000011000000000000000000000";
    report "started" severity note;



  elsif writingreg = 3 then
    rf_write_enable <= '1';
    rf_write_reg <= std_logic_vector(to_unsigned(2, 5));
    rf_write_data <= std_logic_vector(to_unsigned(7, 32));
    writingreg <= 2;

    inswrite <= '1';
    insaddr <= std_logic_vector(to_unsigned(1, 32));
    insdatain <= "00010000001000010001100000000000";
    report "started" severity note;

  elsif writingreg = 4 then

    rf_write_enable <= '1';
    rf_write_reg <= std_logic_vector(to_unsigned(1, 5));
    rf_write_data <= std_logic_vector(to_unsigned(5, 32));
    startpc <= std_logic_vector(to_unsigned(0, 32));

    inswrite <= '1';
    insaddr <= std_logic_vector(to_unsigned(0, 32));
    insdatain <= "00000100001000100001100000000010";

    writingreg <= 3;
  end if;
  wait for 20 ns;
  end process;
end behav;
