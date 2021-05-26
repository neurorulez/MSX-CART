

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.std_logic_unsigned.ALL;

entity top is
	port 
	(
		-- Clocks
		clock_50_i			: in    std_logic;

		-- Buttons
		btn_n_i				: in    std_logic_vector(2 downto 1);
		--dip_i					: in    std_logic_vector(8 downto 1);
		
		-- SDRAM	(H57V256)
		sdram_ad_o			: out std_logic_vector(12 downto 0);
		sdram_da_io			: inout std_logic_vector(15 downto 0);

		sdram_ba_o			: out std_logic_vector(1 downto 0);
		sdram_dqm_o			: out std_logic_vector(1 downto 0);

		sdram_ras_o			: out std_logic;
		sdram_cas_o			: out std_logic;
		sdram_cke_o			: out std_logic;
		sdram_clk_o			: out std_logic;
		sdram_cs_o			: out std_logic;
		sdram_we_o			: out std_logic;
	

		-- PS2
		ps2_clk_io			: inout std_logic								:= 'Z';
		ps2_data_io			: inout std_logic								:= 'Z';
		ps2_mouse_clk_io  : inout std_logic								:= 'Z';
		ps2_mouse_data_io : inout std_logic								:= 'Z';

		-- SD Card
		sd_cs_n_o			: inout std_logic								:= '1';
		sd_sclk_o			: out   std_logic								:= '0';
		sd_mosi_o			: out   std_logic								:= '0';
		sd_miso_i			: inout std_logic;

		-- Joysticks
		--joy1_up_io			: in std_logic;
		--joy1_down_io		: in std_logic;
		--joy1_left_io		: in std_logic;
		--joy1_right_io		: in std_logic;
		--joy1_p6_io			: inout std_logic;
		--joy1_p7_io			: inout std_logic;
		--joy1_p8_io			: inout std_logic;
		
		--joy2_up_io			: inout std_logic;
		--joy2_down_io		: inout std_logic;
		--joy2_left_io		: inout std_logic;
		--joy2_right_io		: inout std_logic;
		--joy2_p6_io			: inout std_logic;
		--joy2_p7_io			: inout std_logic;
		--joy2_p8_io			: inout std_logic;
		JOY_CLK     : out   std_logic;
		JOY_LOAD    : out   std_logic;
		JOY_DATA    : in    std_logic;
		JOY_SELECT  : out   std_logic;
	
		-- Audio
		dac_l_o				: out   std_logic;
		dac_r_o				: out   std_logic;
		ear_i					: in    std_logic;
		mic_o					: out   std_logic								:= '0';

		-- VGA
		vga_r_o				: out   std_logic_vector(5 downto 0)	:= (others => '0');
		vga_g_o				: out   std_logic_vector(5 downto 0)	:= (others => '0');
		vga_b_o				: out   std_logic_vector(5 downto 0)	:= (others => '0');
		vga_hsync_n_o		: out   std_logic								:= '1';
		vga_vsync_n_o		: out   std_logic								:= '1';

		-- External Slots
		slot_A_o				: inout   std_logic_vector(15 downto 0)	:= (others => 'Z');
		slot_D_io			: inout std_logic_vector(7 downto 0)	:= (others => 'Z');
		slot_CS1_o			: inout   std_logic 							:= 'Z';
		slot_CS2_o			: inout   std_logic 							:= 'Z';
		slot_CLOCK_o		: inout   std_logic 							:= 'Z';		
		slot_M1_o			: inout   std_logic 							:= 'Z';		
		slot_MREQ_o			: inout   std_logic 							:= 'Z';		
		slot_IOREQ_o		: inout   std_logic 							:= 'Z';		
		slot_RD_o			: inout   std_logic 							:= 'Z';		
		slot_WR_o			: inout   std_logic 							:= 'Z';		
		slot_RESET_io		: inout std_logic 							:= 'Z';		
		slot_SLOT1_o		: inout   std_logic 							:= 'Z';		
		slot_SLOT2_o		: inout   std_logic 							:= 'Z';			
		slot_SLOT3_o		: inout   std_logic 							:= 'Z';	
		slot_BUSDIR_i		: inout    std_logic 						:= 'Z';	
		slot_RFSH_i			: inout    std_logic 						:= 'Z';	
		slot_INT_i			: inout    std_logic 						:= 'Z';	
		slot_WAIT_i			: inout    std_logic 						:= 'Z';	
		
		slot_DATA_OE_o		: out std_logic 								:= 'Z';	
		slot_DATA_DIR_o	: out std_logic 								:= 'Z';	

		--ESP
		esp_rx_o				: out std_logic		:= 'Z'; 
		esp_tx_i				: in  std_logic		:= 'Z';
		
		--STM
		stm_rst_o         : out std_logic		:= '0'; 
		
		-- LED
		led_o					: out std_logic		:= '0'
		

	);
end entity;

architecture Behavior of top is
	
	component ps2mouse 
	port
	(
		clk 		: in std_logic;		    					-- bus clock
		reset 	: in std_logic;			   				-- reset 
		
		ps2mdat 	: inout std_logic;			 				-- mouse PS/2 data
		ps2mclk 	: inout std_logic;			 				-- mouse PS/2 clk
		
		mou_emu 	: in std_logic_vector(5 downto 0); 		-- mouse with joystick input
		sof 		: in std_logic;								-- mouse joystick emulation enable bit
		zcount	: out std_logic_vector(7 downto 0);  	-- mouse Z counter
		ycount	: out std_logic_vector(7 downto 0);		-- mouse Y counter
		xcount	: out std_logic_vector(7 downto 0);		-- mouse X counter
		mleft		: out std_logic;								-- left mouse button output
		mthird	: out std_logic;								-- third(middle) mouse button output
		mright	: out std_logic;								-- right mouse button output
		test_load: in std_logic;								-- load test value to mouse counter
		test_data: in std_logic_vector(15 downto 0);		-- mouse counter test value
		mouse_data_out	: out std_logic						--mouse has data to present
  );
  end component;

	-- clocks	
	signal clk_sdram			: std_logic;		
	signal clk21m				: std_logic;

	-- Reset signal
	signal reset_n_s			: std_logic;		-- Reset geral
	signal power_on_s			: std_logic_vector(7 downto 0)	:= (others => '1');
	signal power_on_reset 	: std_logic := '1';
	
	signal mute_on_s			: std_logic_vector(20 downto 0)	:= (others => '1');
	signal mute_on_reset 	: std_logic := '1';
	
	-- DIPs
	signal dip_i				: std_logic_vector(7 downto 0) := "00100001";		-- Attention! Inverted bits (0 = enabled)
	
	-- VGA
	signal vga_r_s				: std_logic_vector(5 downto 0)	:= (others => '0');
	signal vga_g_s				: std_logic_vector(5 downto 0)	:= (others => '0');
	signal vga_b_s				: std_logic_vector(5 downto 0)	:= (others => '0');
	signal vga_hsync_n_s		: std_logic								:= '1';
	signal vga_vsync_n_s		: std_logic								:= '1';
	signal vga_csync_n_s		: std_logic								:= '1';
	signal blank_s				: std_logic;
	signal vga_r_s_osd		: std_logic_vector(7 downto 0)	:= (others => '0');
	signal vga_g_s_osd		: std_logic_vector(7 downto 0)	:= (others => '0');
	signal vga_b_s_osd		: std_logic_vector(7 downto 0)	:= (others => '0');
	
	--audio
	signal SL_s					: std_logic_vector(5 downto 0)	:= (others => '0');
	signal SR_s					: std_logic_vector(5 downto 0)	:= (others => '0');
	signal dac_out				: std_logic_vector(15 downto 0)	:= (others => '0');	
	signal audio_deltasigma : std_logic;
	-- slot
	signal cpu_ioreq_s		: std_logic;
	signal cpu_mreq_s			: std_logic;
	signal cpu_rd_s			: std_logic;
	signal slot_SLOT1_s		: std_logic;
	signal slot_SLOT2_s		: std_logic;
	signal BusDir_s			: std_logic;
	
	-- MIDI
	signal midi_o_s 			: std_logic := 'Z';
	signal midi_active_s 	: std_logic := 'Z';
	signal joy2_up_s 			: std_logic := 'Z';

	-- scanlines
	signal scanlines_en_s		: std_logic_vector (1 downto 0)	:= (others => '0');	
	signal btn_scan_s				: std_logic;
	signal odd_line_s				: std_logic := '0';
	signal vga_r_out_s			: std_logic_vector( 5 downto 0);
	signal vga_g_out_s			: std_logic_vector( 5 downto 0);
	signal vga_b_out_s			: std_logic_vector( 5 downto 0);
	
	-- Mouse
	signal clock_div_q		: unsigned(5 downto 0) 	:= (others => '0');	
	signal mouse_x_s			: std_logic_vector( 7 downto 0);
	signal mouse_y_s			: std_logic_vector( 7 downto 0);
	signal mouse_bts_s		: std_logic_vector( 2 downto 0);
	signal mouse_wheel_s		: std_logic_vector( 7 downto 0);
	signal mouse_dat_s 		: std_logic_vector(3 downto 0);
	signal strA_s 				: std_logic;
	signal joymouse_s 		: std_logic_vector(5 downto 0);
	signal mouse_data_out	: std_logic;
	signal mouse_idle			: std_logic := '1';
	signal mouse_present		: std_logic := '0';
		
	type mouse_states			is ( MOUSE_WAIT, MOUSE_START, MOUSE_HIGHX, MOUSE_LOWX, MOUSE_HIGHY, MOUSE_LOWY );
	signal mouse_state 		: mouse_states := MOUSE_WAIT;

	--
	signal hcnt			: std_logic_vector( 10 downto 0);
   signal status     : std_logic_vector( 31 downto 0);
	signal joy1_s 		: std_logic_vector(6 downto 0);
	signal joy2_s 		: std_logic_vector(6 downto 0);
	--

	begin

	--status(3) cartucho 1 (1 = vacio / 0= SCC+) lo ponemos al reves que OSD
	stm_rst_o <= '0';	  
--	dip_i <=	'0' & not status(6) & status(5) & not status(4) & not status(3) & (status(1) and status(8)) & not status(1) & not status(2);
	dip_i <=	'0' & not status(6) & status(5) & not status(4) & not status(3) & (not status(1) and status(8)) & status(1) & not status(2);
 	reset_n_s <= not status(0);--power_on_reset;

	data_io: work.data_io
	port map
	(	
		clk => clk_sdram,
		CLOCK_50 => clock_50_i,
		reset_n => reset_n_s,
		vga_hsync => vga_hsync_n_s,
		vga_vsync => vga_vsync_n_s,
		red_i      => vga_r_s & "00",
		green_i    => vga_g_s & "00",
		blue_i     => vga_b_s & "00",
		red_o      => vga_r_s_osd,
		green_o    => vga_g_s_osd,
		blue_o     => vga_b_s_osd,
		ps2k_clk_in => ps2_clk_io,
		ps2k_dat_in => ps2_data_io,
		JOY_CLK => JOY_CLK,
		JOY_LOAD => JOY_LOAD,
		JOY_DATA => JOY_DATA,
		JOY_SELECT => JOY_SELECT,
		joy1 => joy1_s,
		joy2 => joy2_s,
		ioctl_ce => '0',
		status => status
	);

	ocm: work.emsx_top
	generic map
	(
		ZemmixNeo   		=> '1'
	)
	port map
	(
        -- Clock, Reset ports
        pClk21m         => clock_50_i,
        pExtClk         => '0',


        -- SD-RAM ports
		  pMemClk				=> clk_sdram,			-- SD-RAM Clock
        pMemCke         	=> sdram_cke_o,   -- SD-RAM Clock enable
        pMemCs_n        	=> sdram_cs_o,    -- SD-RAM Chip select
        pMemRas_n       	=> sdram_ras_o,   -- SD-RAM Row/RAS
        pMemCas_n       	=> sdram_cas_o,   -- SD-RAM /CAS
        pMemWe_n        	=> sdram_we_o,    -- SD-RAM /WE
        pMemUdq         	=> sdram_dqm_o(1),-- SD-RAM UDQM
        pMemLdq         	=> sdram_dqm_o(0),-- SD-RAM LDQM
        pMemBa1         	=> sdram_ba_o(1), -- SD-RAM Bank select address 1
        pMemBa0         	=> sdram_ba_o(0), -- SD-RAM Bank select address 0
        pMemAdr         	=> sdram_ad_o,		-- SD-RAM Address
        pMemDat         	=> sdram_da_io,   -- SD-RAM Data
		
        -- PS/2 keyboard ports
        pPs2Clk         	=> ps2_clk_io,
        pPs2Dat         	=> ps2_data_io,
		
        -- Joystick ports (Port_A, Port_B)
		  pJoyA(5)			=>	joy1_s(5),
		  pJoyA(4)			=> joy1_s(4),
		  pJoyA(3)			=>	joy1_s(0),
		  pJoyA(2)			=>	joy1_s(1),
		  pJoyA(1)			=>	joy1_s(2),
		  pJoyA(0)			=>	joy1_s(3),
 
		  --pJoyA     			=> joymouse_s,  --Para incluir Raton... depurando.
			
		  pJoyB(5)			=>	joy2_s(5), 
		  pJoyB(4)			=> joy2_s(4), 
		  pJoyB(3)			=>	joy2_s(0), 
		  pJoyB(2)			=>	joy2_s(1), 
		  pJoyB(1)			=>	joy2_s(2), 
		  pJoyB(0)			=>	joy2_s(3), 
		  
        pStrA           => strA_s, 
        pStrB           => open,   
	  
        -- SD/MMC slot ports
		  pSd_Ck          => sd_sclk_o,             	-- pin 5 Clock
        pSd_Cm          => sd_mosi_o,             	-- pin 2 Datain
		  pSd_Dt(3)			=> sd_cs_n_o,					-- pin 1 CS
		  pSd_Dt(2)			=> open,
		  pSd_Dt(1)			=> open,
		  pSd_Dt(0)			=> sd_miso_i,					-- pin 7 Dataout


        -- DIP switch, Lamp ports
        pDip            => dip_i,

        -- Video, Audio/CMT ports
        pDac_VR         => vga_r_s,
        pDac_VG         => vga_g_s,
        pDac_VB         => vga_b_s,
		  
        pDac_SL   	   => SL_s,
        pDac_SR	      => SR_s,

        pDac_Out        => dac_out,
        pVideoHS_n      => vga_hsync_n_s,
        pVideoVS_n      => vga_vsync_n_s,
		  pVideoCS_n      => vga_csync_n_s,
		  	  
		  -- MSX cartridge slot ports
        pCpuClk         => slot_CLOCK_o, 
        pSltRst_n       => reset_n_s,-- slot_RESET_io,
		  
        pSltAdr         => slot_A_o,
        pSltDat         => slot_D_io,        

        pSltMerq_n      => cpu_mreq_s,
        pSltIorq_n      => cpu_ioreq_s,
        pSltRd_n        => cpu_rd_s,
        pSltWr_n        => slot_WR_o,
		  
        pSltRfsh_n      => slot_RFSH_i,
        pSltWait_n      => slot_WAIT_i,
        pSltInt_n       => slot_INT_i,
        pSltM1_n        => slot_M1_o,	
		  
        pSltBdir_n      => slot_BUSDIR_i, -- not used
		  pSltSltsl_n     => slot_SLOT1_s,
        pSltSlts2_n     => slot_SLOT2_s,
        pSltCs1_n       => slot_CS1_o,
        pSltCs2_n       => slot_CS2_o,
		  
		  BusDir_o 			=> BusDir_s,

		  --others
		  pSltClk			=> '0',
		  pIopRsv14       => '0',
        pIopRsv15       => '0',
        pIopRsv16       => '0',
        pIopRsv17       => '0',
        pIopRsv18       => '0',
        pIopRsv19       => '0',
        pIopRsv20       => '0',
        pIopRsv21       => '0',
  
		  --extras
		  clk21m_out 		=> clk21m,
		  H_CNT_o           => hcnt,
		  esp_rx_o			=> esp_rx_o,
		  esp_tx_i			=> esp_tx_i,	  
		  blank_o			=> blank_s,
		  ear_i				=> ear_i,
		  mic_o				=> mic_o,
		  midi_o				=> midi_o_s,
		  midi_active_o	=> midi_active_s
		  	
    );
	 
	 --joy1_p8_io <= strA_s;
	 
	 --joy2_up_s <= joy2_up_io; 
	 --joy2_up_io <= midi_o_s when midi_active_s = '1' else 'Z';
	 
	slot_IOREQ_o <= cpu_ioreq_s; 
	slot_MREQ_o	 <= cpu_mreq_s; 
	slot_RD_o	 <= cpu_rd_s;
	slot_SLOT1_o <= slot_SLOT1_s;
	slot_SLOT2_o <= slot_SLOT2_s;
	slot_SLOT3_o <= slot_SLOT1_s;
	
	-- RESET to the SLOT pins
	slot_RESET_io <= reset_n_s;

	-- 74LVC4245
	slot_DATA_OE_o	 <= '0' when slot_SLOT1_s = '0' else
							 '0' when slot_SLOT2_s = '0' else
							 '0' when cpu_ioreq_s = '0' and BusDir_s = '0' else	
							 '1';
	slot_DATA_DIR_o <= not cpu_rd_s; -- port A=SLOT, B=FPGA     DIR(1)=A to B 	
	 
	sdram_clk_o <= clk_sdram;
	
	vga_r_o				<= vga_r_out_s;
	vga_g_o				<= vga_g_out_s;
	vga_b_o				<= vga_b_out_s;
	vga_hsync_n_o		<= vga_hsync_n_s when status(1) = '0' else not (vga_hsync_n_s xor vga_vsync_n_s);
	vga_vsync_n_o		<= vga_vsync_n_s when status(1) = '0' else '1';

	
	--saida left gera pequena interferencia no video
	--dac_l_o <= SL_s(0);-- when mute_on_reset = '1' else '0'; --and btn_n_i(2);
	--dac_r_o <= SR_s(0);-- when mute_on_reset = '1' else '0'; --and btn_n_i(2);
	
		-- power on reset
		process (clk_sdram)
		begin
			if rising_edge(clk_sdram) then
				if power_on_s /= x"00" then
					power_on_s <= power_on_s - 1;
					power_on_reset <= '0';
				else
					power_on_reset <= '1';
				end if;
				
			end if;
		end process;
		
		-- mute on reset
		process (clk21m, reset_n_s)
		begin
			if reset_n_s = '0' then
				mute_on_s <= (others=>'1');
			elsif rising_edge(clk21m) then
				if mute_on_s /= x"00" then
					mute_on_s <= mute_on_s - 1;
					mute_on_reset <= '0';
				else
					mute_on_reset <= '1';
				end if;
				
			end if;
		end process;
	
	---------------------------------
	-- mouse
	---------------------------------	
	
	process(clk21m)
	begin
		if rising_edge(clk21m) then 
			clock_div_q <= clock_div_q + 1;
		end if;
	end process;	
	
	mousectrl: ps2mouse 
	port map
	(
		clk 		=> clock_div_q(5), 	-- need a slower clock to avoid loosing data
		reset 	=> not mute_on_reset, -- slow reset signal
		--
		ps2mdat 	=> ps2_mouse_data_io,	-- mouse PS/2 data
		ps2mclk 	=> ps2_mouse_clk_io,		-- mouse PS/2 clk
		--
		xcount	=> mouse_x_s, 			-- mouse X counter		
		ycount	=> mouse_y_s, 			-- mouse Y counter
		zcount	=> mouse_wheel_s, 	-- mouse Z counter
		mleft		=> mouse_bts_s(0),	-- left mouse button output
		mright	=> mouse_bts_s(1),	-- right mouse button output
		mthird	=> mouse_bts_s(2),	-- third(middle) mouse button output
		--
		sof 		=> '0',					-- mouse joystick emulation enable bit
		mou_emu 	=> (others=>'0'), 	-- mouse with joystick input
		--
		test_load=> '0',					-- load test value to mouse counter
		test_data=> (others=>'0'),		-- mouse counter test value
		mouse_data_out => mouse_data_out -- mouse has data top present
   );
	
	
	joymouse_s <= mouse_bts_s(1 downto 0) & mouse_dat_s when mouse_present = '1' else joy1_s(5)& joy1_s(4) & joy1_s(0) & joy1_s(1) & joy1_s(2) & joy1_s(3); 

	led_o <= mouse_present;
	
	process(clk_sdram)
	begin

	if rising_edge(clk_sdram) then
	
		case mouse_state is
			when MOUSE_WAIT =>
				mouse_dat_s <= "0000";
				if mouse_data_out='1' then
					mouse_state <= MOUSE_START;
				end if;

			when MOUSE_START =>
				mouse_present<='1';
				if strA_s = '1' then
					mouse_state <= MOUSE_HIGHX;
				end if;
			
			when MOUSE_HIGHX =>
				mouse_dat_s <= mouse_x_s(7 downto 4);
				if strA_s = '0' then
					mouse_state <= MOUSE_LOWX;
				end if;
				
			when MOUSE_LOWX =>
				mouse_dat_s <= mouse_x_s(3 downto 0);
				if strA_s = '1' then
					mouse_state <= MOUSE_HIGHY;
				end if;
			
			when MOUSE_HIGHY =>
				mouse_dat_s <= mouse_y_s(7 downto 4);
				if strA_s = '0' then
					mouse_state <= MOUSE_LOWY;
				end if;
			
			when MOUSE_LOWY =>
				mouse_dat_s <= mouse_y_s(3 downto 0);
				if strA_s = '1' then
					mouse_state <= MOUSE_WAIT;
				end if;
			
			when others =>
				mouse_state <= MOUSE_WAIT;
		end case;
		
		if joy1_s(5)= '0' or joy1_s(4) = '0' or joy1_s(3) = '0' or joy1_s(2)= '0' or joy1_s(1) = '0' or joy1_s(0) = '0' then
			mouse_present<='0';
		end if;
		
	end if;

end process;

	---------------------------------
	-- scanlines
	---------------------------------
	
	scanlines_en_s <= status(11 downto 10);

 	process (clk21m)
 	 	variable r_v : unsigned(5 downto 0);
 		variable g_v : unsigned(5 downto 0);
 		variable b_v : unsigned(5 downto 0);
 	 begin
 		  if rising_edge(clk21m) then
 		  
 					vga_r_out_s <= vga_r_s_osd(7 downto 2); --vga_r_s(5 downto 1);
 					vga_g_out_s <= vga_g_s_osd(7 downto 2); --vga_g_s(5 downto 1);
 					vga_b_out_s <= vga_b_s_osd(7 downto 2); --vga_b_s(5 downto 1);
 		  
 					 if odd_line_s = '0' then
 					 
 							if scanlines_en_s = "11" then -- 75%
 									vga_r_out_s <=  "00" & vga_r_s_osd(7 downto 4); --vga_r_s(5 downto 3);
 									vga_g_out_s <=  "00" & vga_g_s_osd(7 downto 4); --vga_g_s(5 downto 3);
 									vga_b_out_s <=  "00" & vga_b_s_osd(7 downto 4); --vga_b_s(5 downto 3);
 									
 							elsif scanlines_en_s = "10" then -- 50%
 									vga_r_out_s <=  '0' & vga_r_s_osd(7 downto 3); --vga_r_s(5 downto 2);
 									vga_g_out_s <=  '0' & vga_r_s_osd(7 downto 3); --vga_g_s(5 downto 2);
 									vga_b_out_s <=  '0' & vga_r_s_osd(7 downto 3); --vga_b_s(5 downto 2);
 									
 							elsif scanlines_en_s = "01" then -- 25%
 								r_v := unsigned('0' & vga_r_s_osd(7 downto 3)) + unsigned("00" & vga_r_s_osd(7 downto 4)); --unsigned('0' & vga_r_s(5 downto 2)) + unsigned("00" & vga_r_s(5 downto 3));
 								g_v := unsigned('0' & vga_g_s_osd(7 downto 3)) + unsigned("00" & vga_g_s_osd(7 downto 4));
 								b_v := unsigned('0' & vga_b_s_osd(7 downto 3)) + unsigned("00" & vga_b_s_osd(7 downto 4));
 
 								vga_r_out_s <= std_logic_vector(r_v);
 								vga_g_out_s <= std_logic_vector(g_v);
 								vga_b_out_s <= std_logic_vector(b_v);
 							end if;
 							
 					 end if;
 					 
 
 					 
 				end if;
 	 end process;
	
	process(vga_hsync_n_s,vga_vsync_n_s)
	begin
		if vga_vsync_n_s = '0' then
			odd_line_s <= '0';
		elsif rising_edge(vga_hsync_n_s) then
			odd_line_s <= not odd_line_s;
		end if;
	end process;
	
--SOUND

	dac: work.esepwm
	generic map
	(
		MSBI			=> 15
	)
	port map
	(
    clk => clk21m,
    reset  => not reset_n_s,
    DACin  => not dac_out(15) & dac_out(14 downto 0),
    DACout => audio_deltasigma
	);	

	dac_l_o <= audio_deltasigma;
	dac_r_o <= audio_deltasigma;
	
end architecture;
