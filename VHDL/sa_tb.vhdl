library work;
use work.array_vector_package.all;

library ieee;
use ieee.std_logic_1164.all;

entity sa_tb is		-- systolic array testbench
end sa_tb;

architecture test of sa_tb is
	component sa is -- systolic array
        generic (
        systolicArraySize:integer := 8;                                             -- for setting the size of the calculation matrix
        bitSize:integer := 8                                                        -- fixed to 8 for this project
    );    
	port (
		upperInputVectors : in std_1d_vector_array(0 to systolicArraySize-1);              -- input 1: (top)	1-dimensional array of: 8-bit signed (2k) data
        leftInputVectors : in std_1d_vector_array(0 to systolicArraySize-1);               -- input 2: (left)	1-dimensional array of: 8-bit signed (2k) data
        clk : in std_logic;                                                         -- clock
        reset : in std_logic;                                                       -- reset (each cell (-> d) to "00000000")
        outMatrix : out std_2d_vector_array(0 to systolicArraySize-1, 0 to systolicArraySize-1)   -- output: (back)	2-dimensional array of: 8-bit signed (2k) data
	);
    end component sa;

    constant array_size : integer := 8;		-- you can change the size of the sa here --
    
	signal a, b: std_1d_vector_array(0 to array_size-1)  ;

	signal c, r: std_logic;
	signal d: std_2d_vector_array(0 to array_size-1, 0 to array_size-1);
	
begin
    sa1: sa generic map(systolicArraySize=>array_size, bitSize=>8)port map(upperInputVectors => a, leftInputVectors => b, clk => c, reset => r, outMatrix => d);
	
	process begin
        forloopc: for i in 100 downto 0 loop	-- for repeating the clock signal	(until 1000 ns)
            c <= '0';
            wait for 5 ns;
            c <= '1';
            wait for 5 ns;
        end loop;
        wait;
    end process;
    
	process begin
		for i in 0 to 7 loop	-- set all inputs
            a(i) <= "00000100";
            b(i) <= "00000010";
        end loop;
		
        r <= '1';
        wait for 1 ns;			-- reset first
        r <= '0';
        wait for 1 ns;
		
        wait for 100 ns;		-- wait for calculations of the mac units	(tip: in gtkwave: use hardware tree to dig down into the mac you want to see)
		
        for i in 0 to 7 loop	-- set all inputs to "00000000"
            a(i) <= "00000000";
            b(i) <= "00000000";
        end loop;
		wait;
	end process;
end test;
