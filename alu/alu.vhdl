library ieee;
use ieee.std_logic_1164.all;

entity alu is
  port(
    a: in std_logic_vector(31 downto 0);
    b: in std_logic_vector(31 downto 0);
    op: in std_logic_vector(2 downto 0);
    o: out std_logic_vector(31 downto 0);
    z: out std_logic
  );
end alu;

architecture struct of alu is
    component adder
    port (
      N1: in std_logic_vector(15 downto 0);
      N2: in std_logic_vector(15 downto 0);
      Result: inout std_logic_vector(15 downto 0)
    );
  end component;
  component multiplier
  port (
    Nibble1: in std_logic_vector(15 downto 0);
    Nibble2: in std_logic_vector(15 downto 0);
    Result: inout std_logic_vector(15 downto 0)
  );
  end component;
  component divider
  port (
    Nibble1: in std_logic_vector(15 downto 0);
    Nibble2: in std_logic_vector(15 downto 0);
    Result: inout std_logic_vector(15 downto 0)
  );
  end component;
  component mux2_1_16b
  port (
    i0: in std_logic_vector(15 downto 0);
    i1: in std_logic_vector(15 downto 0);
    s: in std_logic;
    o: out std_logic_vector(15 downto 0)
  );
  end component;
  component mux8_1_32b
  port (
    i0, i1, i2, i3, i4, i5, i6, i7: in std_logic_vector(31 downto 0);
    s: in std_logic_vector(2 downto 0);
    o: out std_logic_vector(31 downto 0)
  );
  end component;
  component neger_16b
  port (
    i: in std_logic_vector(15 downto 0);
    o: out std_logic_vector(15 downto 0)
  );
  end component;
  signal rsum, vsum, rsub, vsub, rmult, vmult, rdiv, vdiv, sum, sub, mult, div, rnega, rnegb, vnega, vnegb, rmux, vmux: std_logic_vector(15 downto 0);
  signal nsum, nsub, nmult, ndiv, nnega, nnegb: std_logic_vector(31 downto 0);
  begin
    -------------------------------------------------------- NEGER
    r_negb: neger_16b port map(b(31 downto 16), rnegb);
    v_negb: neger_16b port map(b(15 downto 0), vnegb);

    -------------------------------------------------------- NEG-MUXES
    r_mux: mux2_1_16b port map(b(31 downto 16), rnegb, op(0), rmux);
    v_mux: mux2_1_16b port map(b(15 downto 0), vnegb, op(0), vmux);

    -------------------------------------------------------- ADDER
    r_adder: adder port map(a(31 downto 16), rmux, rsum);
    v_adder: adder port map(a(15 downto 0), vmux, vsum);

    -------------------------------------------------------- MULTIPLIER

    r_mult: multiplier port map(a(31 downto 16), b(31 downto 16), rmult);
    v_mult: multiplier port map(a(15 downto 0), b(15 downto 0), vmult);

    -------------------------------------------------------- Divider

    r_div: divider port map(a(31 downto 16), b(31 downto 16), rdiv);
    v_div: divider port map(a(15 downto 0), b(15 downto 0), vdiv);

    -------------------------------------------------------- SELECTOR
    nsum <= rsum & vsum;
    nsub <= rsum & vsum;
    nmult <= rmult & vmult;
    ndiv <= rdiv & vdiv;
    nnega <= rnega & vnega;
    nnegb <= rnegb & vnegb;
    alu_sum: mux8_1_32b port map(a, b, nsum, nsub, nmult, ndiv, nnega, nnegb, op, o);

    process (a, b, op)
      begin
        if (a = b) then
          z <= '1';
        else
          z <= '0';
        end if;
      end process;
end;
