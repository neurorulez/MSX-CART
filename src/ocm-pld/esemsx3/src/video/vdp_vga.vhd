--
--  vdp_vga.vhd
--   VGA up-scan converter.
--
--  Copyright (C) 2006 Kunihiko Ohnaka
--  All rights reserved.
--                                     http://www.ohnaka.jp/ese-vdp/
--
--  ï¿½{ï¿½\ï¿½tï¿½gï¿½Eï¿½Fï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½Ñ–{ï¿½\ï¿½tï¿½gï¿½Eï¿½Fï¿½Aï¿½ÉŠï¿½ï¿½Ã‚ï¿½ï¿½Äì¬ï¿½ï¿½ï¿½ê‚½ï¿½hï¿½ï¿½ï¿½ï¿½ï¿½ÍAï¿½È‰ï¿½ï¿½Ìï¿½ï¿½
--  ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ê‡ï¿½ÉŒï¿½ï¿½ï¿½Aï¿½Ä”Ð•zï¿½ï¿½ï¿½ï¿½ï¿½ÑŽgï¿½pï¿½ï¿½ï¿½ï¿½ï¿½Â‚ï¿½ï¿½ï¿½ï¿½Ü‚ï¿½ï¿½B
--
--  1.ï¿½\ï¿½[ï¿½Xï¿½Rï¿½[ï¿½hï¿½`ï¿½ï¿½ï¿½ÅÄ”Ð•zï¿½ï¿½ï¿½ï¿½ï¿½ê‡ï¿½Aï¿½ï¿½ï¿½Lï¿½Ì’ï¿½ï¿½ìŒ ï¿½\ï¿½ï¿½ï¿½Aï¿½{ï¿½ï¿½ê——ï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½Ñ‰ï¿½ï¿½L
--    ï¿½ÆÓï¿½ï¿½Ì‚Ü‚Ü‚ÌŒ`ï¿½Å•ÛŽï¿½ï¿½ï¿½ï¿½é‚±ï¿½ÆB
--  2.ï¿½oï¿½Cï¿½iï¿½ï¿½ï¿½`ï¿½ï¿½ï¿½ÅÄ”Ð•zï¿½ï¿½ï¿½ï¿½ï¿½ê‡ï¿½Aï¿½Ð•zï¿½ï¿½ï¿½É•tï¿½ï¿½ï¿½Ìƒhï¿½Lï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½gï¿½ï¿½ï¿½ÌŽï¿½ï¿½ï¿½ï¿½ÉAï¿½ï¿½ï¿½Lï¿½ï¿½
--    ï¿½ï¿½ï¿½ìŒ ï¿½\ï¿½ï¿½ï¿½Aï¿½{ï¿½ï¿½ê——ï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½Ñ‰ï¿½ï¿½Lï¿½ÆÓï¿½ï¿½ï¿½Ü‚ß‚é‚±ï¿½ÆB
--  3.ï¿½ï¿½ï¿½Ê‚É‚ï¿½ï¿½éŽ–ï¿½Oï¿½Ì‹ï¿½ï¿½Â‚È‚ï¿½ï¿½ÉAï¿½{ï¿½\ï¿½tï¿½gï¿½Eï¿½Fï¿½Aï¿½ï¿½ï¿½Ì”ï¿½ï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½Ñï¿½ï¿½Æ“Iï¿½Èï¿½ï¿½iï¿½âŠˆï¿½ï¿½
--    ï¿½ÉŽgï¿½pï¿½ï¿½ï¿½È‚ï¿½ï¿½ï¿½ï¿½ÆB
--
--  ï¿½{ï¿½\ï¿½tï¿½gï¿½Eï¿½Fï¿½Aï¿½ÍAï¿½ï¿½ï¿½ìŒ ï¿½Ò‚É‚ï¿½ï¿½ï¿½Äuï¿½ï¿½ï¿½ï¿½ï¿½Ì‚Ü‚Üvï¿½ñ‹Ÿ‚ï¿½ï¿½ï¿½ï¿½Ä‚ï¿½ï¿½Ü‚ï¿½ï¿½Bï¿½ï¿½ï¿½ìŒ ï¿½Ò‚ÍA
--  ï¿½ï¿½ï¿½ï¿½Ú“Iï¿½Ö‚Ì“Kï¿½ï¿½ï¿½ï¿½ï¿½Ì•ÛØAï¿½ï¿½ï¿½iï¿½ï¿½ï¿½Ì•ÛØAï¿½Ü‚ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ÉŒï¿½è‚³ï¿½ï¿½ï¿½È‚ï¿½ï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½È‚é–¾ï¿½ï¿½
--  ï¿½Iï¿½ï¿½ï¿½ï¿½ï¿½ÍˆÃ–Ù‚È•ÛØÓ”Cï¿½ï¿½ï¿½ï¿½ï¿½Ü‚ï¿½ï¿½ï¿½ï¿½Bï¿½ï¿½ï¿½ìŒ ï¿½Ò‚ÍAï¿½ï¿½ï¿½Rï¿½Ì‚ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½í‚¸ï¿½Aï¿½ï¿½ï¿½Q
--  ï¿½ï¿½ï¿½ï¿½ï¿½ÌŒï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½í‚¸ï¿½Aï¿½ï¿½ï¿½ÂÓ”Cï¿½Ìï¿½ï¿½ï¿½ï¿½ï¿½ï¿½_ï¿½ï¿½ï¿½Å‚ï¿½ï¿½é‚©ï¿½ï¿½ï¿½iï¿½Ó”Cï¿½Å‚ï¿½ï¿½é‚©ï¿½iï¿½ßŽï¿½
--  ï¿½ï¿½ï¿½Ì‘ï¿½ï¿½Ìjï¿½sï¿½@ï¿½sï¿½×‚Å‚ï¿½ï¿½é‚©ï¿½ï¿½ï¿½ï¿½ï¿½í‚¸ï¿½Aï¿½ï¿½ï¿½É‚ï¿½ï¿½Ì‚æ‚¤ï¿½È‘ï¿½ï¿½Qï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Â”\ï¿½ï¿½ï¿½ï¿½ï¿½mï¿½ï¿½
--  ï¿½ï¿½ï¿½ï¿½ï¿½Ä‚ï¿½ï¿½ï¿½ï¿½Æ‚ï¿½ï¿½Ä‚ï¿½ï¿½Aï¿½{ï¿½\ï¿½tï¿½gï¿½Eï¿½Fï¿½Aï¿½ÌŽgï¿½pï¿½É‚ï¿½ï¿½ï¿½Ä”ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½iï¿½ï¿½ï¿½Ö•iï¿½Ü‚ï¿½ï¿½Í‘ï¿½ï¿½pï¿½T
--  ï¿½[ï¿½rï¿½Xï¿½Ì’ï¿½ï¿½Bï¿½Aï¿½gï¿½pï¿½Ì‘rï¿½ï¿½ï¿½Aï¿½fï¿½[ï¿½^ï¿½Ì‘rï¿½ï¿½ï¿½Aï¿½ï¿½ï¿½vï¿½Ì‘rï¿½ï¿½ï¿½Aï¿½Æ–ï¿½ï¿½Ì’ï¿½ï¿½fï¿½ï¿½ï¿½Ü‚ßAï¿½Ü‚ï¿½ï¿½ï¿½
--  ï¿½ï¿½ï¿½ÉŒï¿½è‚³ï¿½ï¿½ï¿½È‚ï¿½ï¿½jï¿½ï¿½ï¿½Ú‘ï¿½ï¿½Qï¿½Aï¿½ÔÚ‘ï¿½ï¿½Qï¿½Aï¿½ï¿½Iï¿½È‘ï¿½ï¿½Qï¿½Aï¿½ï¿½Ê‘ï¿½ï¿½Qï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½Iï¿½ï¿½ï¿½Qï¿½Aï¿½ï¿½
--  ï¿½ï¿½ï¿½ÍŒï¿½ï¿½Ê‘ï¿½ï¿½Qï¿½É‚Â‚ï¿½ï¿½ÄAï¿½ï¿½ï¿½ØÓ”Cï¿½ð•‰‚ï¿½ï¿½È‚ï¿½ï¿½ï¿½ï¿½Ì‚Æ‚ï¿½ï¿½Ü‚ï¿½ï¿½B
--
--  Note that above Japanese version license is the formal document.
--  The following translation is only for reference.
--
--  Redistribution and use of this software or any derivative works,
--  are permitted provided that the following conditions are met:
--
--  1. Redistributions of source code must retain the above copyright
--     notice, this list of conditions and the following disclaimer.
--  2. Redistributions in binary form must reproduce the above
--     copyright notice, this list of conditions and the following
--     disclaimer in the documentation and/or other materials
--     provided with the distribution.
--  3. Redistributions may not be sold, nor may they be used in a
--     commercial product or activity without specific prior written
--     permission.
--
--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
--  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
--  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
--  FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
--  COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
--  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
--  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
--  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
--  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
--  ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
--  POSSIBILITY OF SUCH DAMAGE.
--
-------------------------------------------------------------------------------
-- Memo
--   Japanese comment lines are starts with "JP:".
--   JP: ï¿½ï¿½ï¿½{ï¿½ï¿½ï¿½ÌƒRï¿½ï¿½ï¿½ï¿½ï¿½gï¿½sï¿½ï¿½ JP:ï¿½ð“ª‚É•tï¿½ï¿½ï¿½éŽ–ï¿½É‚ï¿½ï¿½ï¿½
--
-------------------------------------------------------------------------------
-- Revision History
--
-- 3rd,June,2018 modified by KdL
--  - Added a trick to help set a pixel ratio 1:1
--    on an LED display at 60Hz (not guaranteed on all displays)
--
-- 29th,October,2006 modified by Kunihiko Ohnaka
--  - Inserted the license text
--  - Added the document part below
--
-- ??th,August,2006 modified by Kunihiko Ohnaka
--  - Moved the equalization pulse generator from vdp.vhd
--
-- 20th,August,2006 modified by Kunihiko Ohnaka
--  - Changed field mapping algorithm when interlace mode is enabled
--        even field  -> even line (odd  line is black)
--        odd  field  -> odd line  (even line is black)
--
-- 13th,October,2003 created by Kunihiko Ohnaka
-- JP: VDPï¿½ÌƒRï¿½Aï¿½ÌŽï¿½ï¿½ï¿½Æ•\ï¿½ï¿½ï¿½fï¿½oï¿½Cï¿½Xï¿½Ö‚Ìoï¿½Í‚ï¿½ï¿½Êƒ\ï¿½[ï¿½Xï¿½É‚ï¿½ï¿½ï¿½ï¿½D
--
-------------------------------------------------------------------------------
-- Document
--
-- JP: ESE-VDPï¿½Rï¿½A(vdp.vhd)ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½rï¿½fï¿½Iï¿½Mï¿½ï¿½ï¿½ï¿½ï¿½AVGAï¿½^ï¿½Cï¿½~ï¿½ï¿½ï¿½Oï¿½ï¿½
-- JP: ï¿½ÏŠï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Aï¿½bï¿½vï¿½Xï¿½Lï¿½ï¿½ï¿½ï¿½ï¿½Rï¿½ï¿½ï¿½oï¿½[ï¿½^ï¿½Å‚ï¿½ï¿½B
-- JP: NTSCï¿½Íï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½gï¿½ï¿½ï¿½ï¿½15.7KHzï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½gï¿½ï¿½ï¿½ï¿½60Hzï¿½Å‚ï¿½ï¿½ï¿½ï¿½A
-- JP: VGAï¿½Ìï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½gï¿½ï¿½ï¿½ï¿½31.5KHzï¿½Aï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½gï¿½ï¿½ï¿½ï¿½60Hzï¿½Å‚ï¿½ï¿½ï¿½ï¿½A
-- JP: ï¿½ï¿½ï¿½Cï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ù‚Ú”{ï¿½É‚È‚ï¿½ï¿½ï¿½æ‚¤ï¿½Èƒ^ï¿½Cï¿½~ï¿½ï¿½ï¿½Oï¿½É‚È‚ï¿½ï¿½Ü‚ï¿½ï¿½B
-- JP: ï¿½ï¿½ï¿½ï¿½ï¿½ÅAvdpï¿½ï¿½ ntscï¿½ï¿½ï¿½[ï¿½hï¿½Å“ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Aï¿½eï¿½ï¿½ï¿½Cï¿½ï¿½ï¿½ï¿½ï¿½{ï¿½Ì‘ï¿½ï¿½xï¿½ï¿½
-- JP: ï¿½ï¿½ï¿½xï¿½`ï¿½æ‚·ï¿½é‚±ï¿½Æ‚ÅƒXï¿½Lï¿½ï¿½ï¿½ï¿½ï¿½Rï¿½ï¿½ï¿½oï¿½[ï¿½gï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½Ä‚ï¿½ï¿½Ü‚ï¿½ï¿½B
--

LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;
    USE WORK.VDP_PACKAGE.ALL;

ENTITY VDP_VGA IS
    PORT(
        -- VDP CLOCK ... 21.477MHZ
        CLK21M          : IN    STD_LOGIC;
        RESET           : IN    STD_LOGIC;
        -- VIDEO INPUT
        VIDEORIN        : IN    STD_LOGIC_VECTOR( 5 DOWNTO 0);
        VIDEOGIN        : IN    STD_LOGIC_VECTOR( 5 DOWNTO 0);
        VIDEOBIN        : IN    STD_LOGIC_VECTOR( 5 DOWNTO 0);
        VIDEOVSIN_N     : IN    STD_LOGIC;
        HCOUNTERIN      : IN    STD_LOGIC_VECTOR(10 DOWNTO 0);
        VCOUNTERIN      : IN    STD_LOGIC_VECTOR(10 DOWNTO 0);
        -- MODE
        PALMODE         : IN    STD_LOGIC;  -- caro
        INTERLACEMODE   : IN    STD_LOGIC;
        LEGACY_VGA      : IN    STD_LOGIC;
        -- VIDEO OUTPUT
        VIDEOROUT       : OUT   STD_LOGIC_VECTOR( 5 DOWNTO 0);
        VIDEOGOUT       : OUT   STD_LOGIC_VECTOR( 5 DOWNTO 0);
        VIDEOBOUT       : OUT   STD_LOGIC_VECTOR( 5 DOWNTO 0);
        VIDEOHSOUT_N    : OUT   STD_LOGIC;
        VIDEOVSOUT_N    : OUT   STD_LOGIC;
		BLANK_o         : OUT   STD_LOGIC;
        -- SWITCHED I/O SIGNALS
        RATIOMODE       : IN    STD_LOGIC_VECTOR( 2 DOWNTO 0)
    );
END VDP_VGA;

ARCHITECTURE RTL OF VDP_VGA IS
    COMPONENT VDP_DOUBLEBUF
        PORT (
            CLK         : IN    STD_LOGIC;
            XPOSITIONW  : IN    STD_LOGIC_VECTOR(  9 DOWNTO 0 );
            XPOSITIONR  : IN    STD_LOGIC_VECTOR(  9 DOWNTO 0 );
            EVENODD     : IN    STD_LOGIC;
            WE          : IN    STD_LOGIC;
            DATARIN     : IN    STD_LOGIC_VECTOR(  5 DOWNTO 0 );
            DATAGIN     : IN    STD_LOGIC_VECTOR(  5 DOWNTO 0 );
            DATABIN     : IN    STD_LOGIC_VECTOR(  5 DOWNTO 0 );
            DATAROUT    : OUT   STD_LOGIC_VECTOR(  5 DOWNTO 0 );
            DATAGOUT    : OUT   STD_LOGIC_VECTOR(  5 DOWNTO 0 );
            DATABOUT    : OUT   STD_LOGIC_VECTOR(  5 DOWNTO 0 )
        );
    END COMPONENT;

    SIGNAL FF_HSYNC_N   : STD_LOGIC;
    SIGNAL vsync_s   : STD_LOGIC;
	 
    -- VIDEO OUTPUT ENABLE
    SIGNAL VIDEOOUTX    : STD_LOGIC;

    -- DOUBLE BUFFER SIGNAL
    SIGNAL XPOSITIONW   : STD_LOGIC_VECTOR(  9 DOWNTO 0 );
    SIGNAL XPOSITIONR   : STD_LOGIC_VECTOR(  9 DOWNTO 0 );
    SIGNAL EVENODD      : STD_LOGIC;
    SIGNAL WE_BUF       : STD_LOGIC;
    SIGNAL DATAROUT     : STD_LOGIC_VECTOR(  5 DOWNTO 0 );
    SIGNAL DATAGOUT     : STD_LOGIC_VECTOR(  5 DOWNTO 0 );
    SIGNAL DATABOUT     : STD_LOGIC_VECTOR(  5 DOWNTO 0 );

    -- DISP_START_X + DISP_WIDTH < CLOCKS_PER_LINE/2 = 684
    CONSTANT DISP_WIDTH             : INTEGER := 576;
    SHARED VARIABLE DISP_START_X    : INTEGER := 684 - DISP_WIDTH - 2;          -- 106
BEGIN

    VIDEOROUT <= DATAROUT WHEN VIDEOOUTX = '1' ELSE (OTHERS => '0');
    VIDEOGOUT <= DATAGOUT WHEN VIDEOOUTX = '1' ELSE (OTHERS => '0');
    VIDEOBOUT <= DATABOUT WHEN VIDEOOUTX = '1' ELSE (OTHERS => '0');

    DBUF : VDP_DOUBLEBUF
    PORT MAP(
        CLK         => CLK21M,
        XPOSITIONW  => XPOSITIONW,
        XPOSITIONR  => XPOSITIONR,
        EVENODD     => EVENODD,
        WE          => WE_BUF,
        DATARIN     => VIDEORIN,
        DATAGIN     => VIDEOGIN,
        DATABIN     => VIDEOBIN,
        DATAROUT    => DATAROUT,
        DATAGOUT    => DATAGOUT,
        DATABOUT    => DATABOUT
    );

    XPOSITIONW  <=  HCOUNTERIN(10 DOWNTO 1) - (CLOCKS_PER_LINE/2 - DISP_WIDTH - 10);
    EVENODD     <=  VCOUNTERIN(1);
    WE_BUF      <=  '1';

    -- PIXEL RATIO 1:1 FOR LED DISPLAY
    PROCESS( CLK21M )
        CONSTANT DISP_START_Y   : INTEGER := 3;
        CONSTANT PRB_HEIGHT     : INTEGER := 25;
        CONSTANT RIGHT_X        : INTEGER := 684 - DISP_WIDTH - 2;              -- 106
        CONSTANT PAL_RIGHT_X    : INTEGER := 87;                                -- 87
        CONSTANT CENTER_X       : INTEGER := RIGHT_X - 32 - 2;                  -- 72
        CONSTANT BASE_LEFT_X    : INTEGER := CENTER_X - 32 - 2 - 3;             -- 35
    BEGIN
        IF( CLK21M'EVENT AND CLK21M = '1' )THEN
            IF( (RATIOMODE = "000" OR INTERLACEMODE = '1' OR PALMODE = '1')) then -- AND LEGACY_VGA = '1' )THEN
                -- LEGACY OUTPUT
                DISP_START_X := RIGHT_X;                                        -- 106
            ELSIF( PALMODE = '1' )THEN
                -- 50HZ
                DISP_START_X := PAL_RIGHT_X;                                    -- 87
            ELSIF( RATIOMODE = "000" OR INTERLACEMODE = '1' )THEN
                -- 60HZ
                DISP_START_X := CENTER_X;                                       -- 72
            ELSIF( (VCOUNTERIN < 38 + DISP_START_Y + PRB_HEIGHT) OR
                   (VCOUNTERIN > 526 - PRB_HEIGHT AND VCOUNTERIN < 526 ) OR
                   (VCOUNTERIN > 524 + 38 + DISP_START_Y AND VCOUNTERIN < 524 + 38 + DISP_START_Y + PRB_HEIGHT) OR
                   (VCOUNTERIN > 524 + 526 - PRB_HEIGHT) )THEN
                -- PIXEL RATIO 1:1 (VGA MODE, 60HZ, NOT INTERLACED)
--                IF( EVENODD = '0' )THEN                                         -- PLOT FROM TOP-RIGHT
				IF( EVENODD = '1' )THEN                                         -- PLOT FROM TOP-LEFT
                    DISP_START_X := BASE_LEFT_X + CONV_INTEGER(NOT RATIOMODE);  -- 35 TO 41
                ELSE
                    DISP_START_X := RIGHT_X;                                    -- 106
                END IF;
            ELSE
                DISP_START_X := CENTER_X;                                       -- 72
            END IF;
        END IF;
    END PROCESS;

    -- GENERATE H-SYNC SIGNAL
    PROCESS( RESET, CLK21M )
    BEGIN
        IF( RESET = '1' )THEN
            FF_HSYNC_N <= '1';
        ELSIF( CLK21M'EVENT AND CLK21M = '1' )THEN
            IF( (HCOUNTERIN = 0) OR (HCOUNTERIN = (CLOCKS_PER_LINE/2)) )THEN
                FF_HSYNC_N <= '0';
            ELSIF( (HCOUNTERIN = 40) OR (HCOUNTERIN = (CLOCKS_PER_LINE/2) + 40) )THEN
                FF_HSYNC_N <= '1';
            END IF;
        END IF;
    END PROCESS;

    -- GENERATE V-SYNC SIGNAL
    -- THE VIDEOVSIN_N SIGNAL IS NOT USED
    PROCESS( RESET, CLK21M )
    BEGIN
        IF( RESET = '1' )THEN
            vsync_s <= '1';
        ELSIF( CLK21M'EVENT AND CLK21M = '1' )THEN
				IF (LEGACY_VGA = '0') then -- HDMI V position align
						IF( (VCOUNTERIN = 6+12) OR (VCOUNTERIN = 524 + 6+12) )THEN        
                        vsync_s <= '0';
                  ELSIF( (VCOUNTERIN = 12+12) OR (VCOUNTERIN = 524 + 12+12) )THEN
                       vsync_s <= '1';
                  END IF;
		  
            ELSIF ( PALMODE = '0' ) THEN -- caro
                IF( INTERLACEMODE = '0' ) THEN
                    IF( (VCOUNTERIN = 3*2) OR (VCOUNTERIN = 524 + 3*2 ) )THEN
                        vsync_s <= '0';
                    ELSIF( (VCOUNTERIN = 6*2) OR (VCOUNTERIN = 524 + 6*2 ) )THEN
                       vsync_s <= '1';
                   END IF;
               ELSE
                   IF( (VCOUNTERIN = 3*2) OR (VCOUNTERIN = 525 + 3*2) )THEN
                       vsync_s <= '0';
                   ELSIF( (VCOUNTERIN = 6*2) OR (VCOUNTERIN = 525 + 6*2) )THEN
                       vsync_s <= '1';
                   END IF;
               END IF;
           ELSE
               IF( INTERLACEMODE = '0' ) THEN
                   IF( (VCOUNTERIN = 3*2) OR (VCOUNTERIN = 626 + 3*2) )THEN
                       vsync_s <= '0';
                   ELSIF( (VCOUNTERIN = 6*2) OR (VCOUNTERIN = 626 + 6*2) )THEN
                       vsync_s <= '1';
                   END IF;
               ELSE
                   IF( (VCOUNTERIN = 3*2) OR (VCOUNTERIN = 625 + 3*2) )THEN
                       vsync_s <= '0';
                   ELSIF( (VCOUNTERIN = 6*2) OR (VCOUNTERIN = 625 + 6*2) )THEN
                       vsync_s <= '1';
                   END IF;
               END IF;
         
			END IF;
			
			
						
			
			
        END IF;
    END PROCESS;

    -- GENERATE DATA READ TIMING
    PROCESS( RESET, CLK21M )
    BEGIN
        IF( RESET = '1' )THEN
            XPOSITIONR <= (OTHERS => '0');
        ELSIF( CLK21M'EVENT AND CLK21M = '1' )THEN
            IF( (HCOUNTERIN = DISP_START_X) OR
                    (HCOUNTERIN = DISP_START_X + (CLOCKS_PER_LINE/2)) )THEN
                XPOSITIONR <= (OTHERS => '0');
            ELSE
                XPOSITIONR <= XPOSITIONR + 1;
            END IF;
        END IF;
    END PROCESS;

    -- GENERATE VIDEO OUTPUT TIMING
    PROCESS( RESET, CLK21M )
    BEGIN
        IF( RESET = '1' )THEN
            VIDEOOUTX <= '0';
        ELSIF( CLK21M'EVENT AND CLK21M = '1' )THEN
            IF( (HCOUNTERIN = DISP_START_X) OR
                    ((HCOUNTERIN = DISP_START_X + (CLOCKS_PER_LINE/2)) AND INTERLACEMODE = '0') )THEN
                VIDEOOUTX <= '1';
            ELSIF( (HCOUNTERIN = DISP_START_X + DISP_WIDTH) OR
                       (HCOUNTERIN = DISP_START_X + DISP_WIDTH + (CLOCKS_PER_LINE/2)) )THEN
                VIDEOOUTX <= '0';
            END IF;
        END IF;
    END PROCESS;

    VIDEOHSOUT_N <= FF_HSYNC_N;
	 VIDEOVSOUT_N <= vsync_s;
	 
	BLANK_o <= '1' when VIDEOOUTX = '0' or vsync_s = '0' else '0';
	
END RTL;
