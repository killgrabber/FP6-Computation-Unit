library ieee;
use ieee.std_logic_1164.all;

entity mac is -- multiply-accumulate unit
	port ( -- c: clock; r: reset
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c : in std_logic;
		r : in std_logic
		-- ?
	);
end mac;

architecture behavior of mac is
	component ksa is -- kogge-stone adder
		port ( -- s: sum
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			s : out std_logic_vector(7 downto 0)
		);
	end component ksa;
	
	component wtm is -- wallace-tree multiplier
		port ( -- p: product
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			p : out std_logic_vector(15 downto 0)
		);
	end component wtm;
	
	component fifo is -- first-in first-out (parallel-in parallel-out)
		port ( -- c: clock
			a : in std_logic_vector(7 downto 0);
			c : in std_logic;
			r : in std_logic;
			b : out std_logic_vector(7 downto 0)
		);
	end component fifo;
	
	-- ?
begin
	-- ?
end behavior;