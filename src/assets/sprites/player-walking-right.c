#include "player-walking-right.h"
// Data created with Img2CPC - (c) Retroworks - 2007-2017
// Tile s_player_w_r_0: 16x40 pixels, 8x40 bytes.
const u8 s_player_w_r_0[8 * 40] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x04, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x04, 0x00, 0x00, 0x00, 0xaa,
	0x00, 0x00, 0x19, 0x22, 0x08, 0x00, 0x00, 0xaa,
	0x00, 0x00, 0x33, 0x33, 0x08, 0x00, 0x55, 0xaa,
	0x00, 0x00, 0x33, 0x33, 0x04, 0x00, 0x55, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x22, 0x00, 0xff, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x26, 0x00, 0xaa, 0x00,
	0x00, 0x11, 0x22, 0x11, 0x26, 0x55, 0xaa, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x22, 0xdd, 0x00, 0x00,
	0x00, 0x11, 0x22, 0x11, 0x22, 0xdd, 0x00, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x66, 0x4c, 0x00, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x22, 0x88, 0x00, 0x00,
	0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x11, 0x26, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x88, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0xcc, 0x0c, 0x00, 0x00, 0x00
};

// Tile s_player_w_r_1: 16x40 pixels, 8x40 bytes.
const u8 s_player_w_r_1[8 * 40] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x08, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x08, 0x00, 0x00, 0x55,
	0x00, 0x00, 0x04, 0x0c, 0x08, 0x00, 0x00, 0x55,
	0x00, 0x00, 0x04, 0x04, 0x04, 0x00, 0x00, 0xff,
	0x00, 0x04, 0x08, 0x00, 0x0c, 0x00, 0x00, 0xaa,
	0x00, 0x19, 0x26, 0x04, 0x04, 0x00, 0x55, 0xaa,
	0x00, 0x33, 0x33, 0x08, 0x04, 0x08, 0x55, 0x00,
	0x00, 0x33, 0x33, 0x04, 0x00, 0x08, 0xff, 0x00,
	0x11, 0x33, 0x33, 0x22, 0x08, 0x4c, 0xaa, 0x00,
	0x11, 0x33, 0x33, 0x26, 0x00, 0x44, 0xaa, 0x00,
	0x11, 0x22, 0x11, 0x22, 0x00, 0x8c, 0x88, 0x00,
	0x11, 0x33, 0x33, 0x26, 0x08, 0x44, 0x00, 0x00,
	0x11, 0x22, 0x11, 0x22, 0x08, 0x00, 0x00, 0x00,
	0x11, 0x33, 0x33, 0x26, 0x08, 0x00, 0x00, 0x00,
	0x11, 0x33, 0x33, 0x26, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x33, 0x33, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x33, 0x33, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x11, 0x66, 0x0c, 0x0c, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x88, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x88, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x88, 0x04, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x88, 0x00, 0x08, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x44, 0x00, 0x0c, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x88, 0x00, 0x04, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x00, 0x00, 0x04, 0x00, 0x00,
	0x00, 0x00, 0x88, 0x00, 0x00, 0x04, 0x00, 0x00,
	0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
	0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
	0x00, 0x88, 0x00, 0x00, 0x00, 0x00, 0x08, 0x00,
	0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x0c, 0x00,
	0x00, 0x44, 0xcc, 0x00, 0x00, 0x00, 0x04, 0x0c
};

// Tile s_player_w_r_2: 16x40 pixels, 8x40 bytes.
const u8 s_player_w_r_2[8 * 40] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x04, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x08, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x04, 0x00, 0x00, 0x00, 0xaa,
	0x00, 0x00, 0x19, 0x22, 0x08, 0x00, 0x00, 0xaa,
	0x00, 0x00, 0x33, 0x33, 0x08, 0x00, 0x55, 0xaa,
	0x00, 0x00, 0x33, 0x33, 0x04, 0x00, 0x55, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x22, 0x00, 0xff, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x26, 0x00, 0xaa, 0x00,
	0x00, 0x11, 0x22, 0x11, 0x26, 0x55, 0xaa, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x22, 0xdd, 0x00, 0x00,
	0x00, 0x11, 0x22, 0x11, 0x22, 0xdd, 0x00, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x66, 0x4c, 0x00, 0x00,
	0x00, 0x11, 0x33, 0x33, 0x22, 0x88, 0x00, 0x00,
	0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x33, 0x33, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x11, 0x26, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x88, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0x04, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x44, 0xcc, 0x0c, 0x00, 0x00, 0x00
};

// Tile s_player_w_r_3: 16x40 pixels, 8x40 bytes.
const u8 s_player_w_r_3[8 * 40] = {
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x04, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x0c, 0x08, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x08, 0x08, 0x19, 0x22, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x00, 0x33, 0x33, 0x00, 0x00,
	0x00, 0x00, 0x0c, 0x00, 0x33, 0x33, 0x00, 0xaa,
	0x00, 0x00, 0x04, 0x19, 0x33, 0x33, 0x77, 0x00,
	0x00, 0x00, 0x08, 0x11, 0x33, 0x33, 0x77, 0x00,
	0x00, 0x00, 0x08, 0x19, 0x22, 0x11, 0x22, 0x00,
	0x00, 0x00, 0x04, 0x11, 0x33, 0x33, 0x22, 0x00,
	0x00, 0x00, 0x04, 0x19, 0x22, 0x11, 0x22, 0x00,
	0x00, 0x00, 0x00, 0x11, 0x33, 0x33, 0x22, 0x00,
	0x00, 0x00, 0x00, 0x19, 0x33, 0x33, 0x22, 0x00,
	0x00, 0x00, 0x04, 0x08, 0x33, 0x33, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x0c, 0x33, 0x33, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x08, 0x11, 0x22, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x88, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x88, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0xcc, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x04, 0x44, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x0c, 0x44, 0x88, 0x00, 0x00,
	0x00, 0x00, 0x04, 0x00, 0x00, 0x88, 0x00, 0x00,
	0x00, 0x00, 0x08, 0x00, 0x00, 0x88, 0x00, 0x00,
	0x00, 0x04, 0x00, 0x00, 0x00, 0x88, 0x00, 0x00,
	0x00, 0x08, 0x00, 0x00, 0x00, 0x44, 0x00, 0x00,
	0x00, 0x08, 0x00, 0x00, 0x00, 0x44, 0x00, 0x00,
	0x04, 0x00, 0x00, 0x00, 0x00, 0x44, 0x00, 0x00,
	0x00, 0x08, 0x00, 0x00, 0x00, 0x44, 0x88, 0x00,
	0x00, 0x0c, 0x08, 0x00, 0x00, 0x00, 0xcc, 0x88
};
