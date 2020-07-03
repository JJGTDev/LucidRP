Config = {}
Config.Locale = 'en'

Config.DoorList = {

	-- Bennys Gate
	{
		objName = 'lr_prop_supermod_door_01',
		objCoords  = vector3(-205.6828, -1310.683, 30.29572),
		textCoords = vector3(-207.98, -1310.47, 31.07),
		authorizedJobs = { 'bennys' },
		locked = true,
		distance = 10,
		size = 1
	},
	-- pillbox mixer
	{
		objName = 'gabz_pillbox_singledoor',
		objCoords  = vector3(336.86650, -592.57880, 43.43391),
		textCoords = vector3(336.86650, -592.57880, 43.43391),
		objYaw = 340.129,
		authorizedJobs = { 'ambulance', 'rescue' },
		locked = true,
		distance = 3,
		size = 1
	},
	--
	--
	-- Addons
	--
	-- Coopers
	{
		textCoords = vector3(943.52, -985.48, 39.5),
		authorizedJobs = { 'coopers' },
		locked = true,
		distance = 20,
		size = 1,
		doors = {
			{
				objName = '-983965772',
				objCoords = vector3(945.93520, -985.58400, 41.22465)
			}
		}
	},
	{
		textCoords = vector3(-441.85, 6011.81, 31.72),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_bk_door2',
				objCoords = vector3(-442.82, 6010.93, 31.86),
				objYaw = 225.126,
			},

			{
				objName = 'v_ilev_bk_door2',
				objCoords = vector3(-440.98, 6012.77, 31.86),
				objYaw = 45.038,
			}
		}
	},
	{
		objName = 'v_ilev_gc_door01',
		objCoords  = vector3(-447.22, 6002.32, 31.8),
		textCoords = vector3(-447.22, 6002.32, 31.8),
		authorizedJobs = {'police', 'rescue' },
		locked = true,
		objYaw = 134.837,
		distance = 4,
		size = 1
	},
	{
		objName = 'v_ilev_gc_door01',
		objCoords  = vector3(-450.97, 6006.07, 31.99),
		textCoords = vector3(-450.97, 6006.07, 31.99),
		authorizedJobs = {'police', 'rescue' },
		locked = true,
		objYaw = 315.336,
		distance = 2,
		size = 1
	},
	{
		objName = 'v_ilev_cd_entrydoor',
		objCoords  = vector3(-454.53, 6011.25, 31.86),
		textCoords = vector3(-454.53, 6011.25, 31.86),
		authorizedJobs = {'police', 'rescue' },
		locked = true,
		objYaw = 10.009,
		distance = 4,
		size = 1
	},
	{
		textCoords = vector3(-448.7, 6007.6, 31.72),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ss_door7',
				objCoords = vector3(-449.55, 6008.55, 31.80),
				objYaw = 135.00,
			},

			{
				objName = 'v_ilev_ss_door8',
				objCoords = vector3(-447.70, 6006.71, 31.80),
				objYaw = 315.00,
			}
		}
	},
	{
		objName = 'v_ilev_fingate',
		objCoords  = vector3(-437.61, 5992.81, 31.93),
		textCoords = vector3(-437.61, 5992.81, 31.93),
		authorizedJobs = {'police', 'rescue' },
		locked = true,
		objYaw = 314.742,
		distance = 2,
		size = 1
	},
	-- Los Santos | FBI Building
	-- Entrance Double Doors
	{
		objName = 'v_ilev_fibl_door02',
		objCoords  = vector3(106.37, -742.69, 46.18),
		textCoords = vector3(106.07, -743.76, 46.18),
		authorizedJobs = {'police', 'rescue' },
		locked = false,
		distance = 6
	},
	{
		objName = 'v_ilev_fibl_door01',
		objCoords  = vector3(105.76, -746.64, 46.18),
		textCoords = vector3(105.71, -745.28, 46.18),
		authorizedJobs = {'police', 'rescue' },
		locked = false,
		distance = 6
	},
	{
		objName = 'v_ilev_fib_door1',
		objCoords  = vector3(127.24, -760.45, 45.9),
		textCoords = vector3(127.24, -760.45, 45.9),
		authorizedJobs = {'police', 'rescue' },
		locked = true,
		distance = 2
	},
	
	-----------PAWN SHOP
	{
		objName = 'hei_v_ilev_fh_heistdoor2',
		objYaw = 160.0,
		objCoords  = vector3(97.64151, -226.06, 54.75),
		textCoords = vector3(97.64151, -226.06, 54.75),
		authorizedJobs = { 'pawn' },
		locked = false,
		distance = 2.0,
		size = 0.75,
	},
	-- -----------LOSTMC
	{
		objName = 'v_ilev_lostdoor',
		objYaw = 42.652,
		objCoords  = vector3(981.15, -103.25, 74.99),
		textCoords = vector3(981.15, -103.25, 74.99),
		authorizedJobs = { 'lost_mc' },
		locked = true,
		distance = 2.0,
		size = 0.75,
	},

	-- -- mafia
	{
		textCoords = vector3(1395.84, 1141.76, 114.64),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door4l',
				objYaw = 270.00,
				objCoords = vector3(1395.920, 1142.904, 114.700)
				
			},

			{
				objName = 'v_ilev_ra_door4r',
				objYaw = 90.00,
				objCoords = vector3(1395.919, 1140.704, 114.790)				
			}
		}
	},
	
	--dining room
	{
		textCoords = vector3(1409.12, 1147.33, 114.33),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door1_r',
				objYaw = 90.0,
				objCoords = vector3(1409.292, 1148.454, 114.487)				
			},

			{
				objName = 'v_ilev_ra_door1_l',
				objYaw = 90.0,
				objCoords = vector3(1409.292, 1146.254, 114.487)
			}
		}
	},
	
	--livingroom front doors
	{
		textCoords = vector3(1390.87, 1132.24, 114.33),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door1_l',
				objYaw = 90.0,
				objCoords = vector3(1390.666, 1131.117, 114.481)
			},

			{
				objName = 'v_ilev_ra_door1_r',
				objYaw = 90.0,
				objCoords = vector3(1390.666, 1133.317, 114.481)
			}
		}
	},

	--livingroom side doors
	{
		textCoords = vector3(1400.48, 1128.31, 114.33),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door1_l',
				objYaw = 180.0,
				objCoords = vector3(1400.488, 1128.314, 114.484)				
			},

			{
				objName = 'v_ilev_ra_door1_r',
				objYaw = 180.00,
				objCoords = vector3(1400.488, 1128.314, 114.484)				
			}
		}
	},

	

	--office front doors
	{
		textCoords = vector3(1390.67, 1162.38, 114.37),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door1_r',
				objYaw = 270.0,
				objCoords = vector3(1390.478, 1161.238, 114.483)
			},

			{
				objName = 'v_ilev_ra_door1_l',
				objYaw = 270.0,
				objCoords = vector3(1390.478, 1163.438, 114.483)
			}
		}
	},

	--bedroom left back doors
	{
		textCoords = vector3(1408.46, 1164.73, 114.33),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door1_l',
				objYaw = 270.0,
				objCoords = vector3(1408.581, 1165.834, 114.483)
			},

			{
				objName = 'v_ilev_ra_door1_r',
				objYaw = 270.0,
				objCoords = vector3(1408.581, 1163.634, 114.483)
			}
		}
	},

	--bedroom right back doors
	{
		textCoords = vector3(1408.41, 1160.03, 114.33),
		authorizedJobs = { 'mafia' },
		locked = true,
		distance = 2,
		size = 1,
		doors = {
			{
				objName = 'v_ilev_ra_door1_l',
				objYaw = 270.0,
				objCoords = vector3(1408.581, 1161.165, 114.483)
			},

			{
				objName = 'v_ilev_ra_door1_r',
				objYaw = 270.0,
				objCoords = vector3(1408.581, 1158.965, 114.483)
			}
		}
	},
	-- Interogation Room
	{
		objName = 'v_ilev_ph_gendoor006',
		objYaw = 90.0,
		objCoords  = vector3(469.9, -994.3, 24.9),
		textCoords = vector3(469.9, -994.3, 24.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	--
	-- Sandy Shores
	--

	
	{
		textCoords = vector3(478.45, -988.17, 24.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_gc_door01',
				objYaw = -0.0,
				objCoords  = vector3(478.45, -988.17, 24.9),
			}
		}
	},
	{
		textCoords = vector3(468.1, -1003.16, 24.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate02',
				objYaw = -180.0,
				objCoords  = vector3(468.1, -1003.16, 24.9),
			}
		}
	},
	{
		textCoords = vector3(-432.185,5992.122,31.873),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.0,
				objCoords  = vector3(-432.185,5992.122,31.873),
			}
		}
	},
	{
		textCoords = vector3(-428.065,5996.672,31.873),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.0,
				objCoords  = vector3(-428.065,5996.672,31.873),
			}
		}
	},
	{
		textCoords = vector3(-431.192,5999.742,31.873),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.0,
				objCoords  = vector3(-431.192,5999.742,31.873),
			}
		}
	},

	--
	-- Sandy Shores
	--

	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -240.0,
		objCoords  = vector3(1848.2, 3681.8, 34.2),
		textCoords = vector3(1848.2, 3681.8, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -60.0,
		objCoords  = vector3(1846.7, 3685.1, 34.2),
		textCoords = vector3(1846.0, 3685.0, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 120.0,
		objCoords  = vector3(1850.5, 3682.7, 34.2),
		textCoords = vector3(1850.5, 3682.7, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1845.7, 3688.4, 34.2),
		textCoords = vector3(1845.7, 3688.4, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1848.9, 3690.3, 34.2),
		textCoords = vector3(1848.9, 3690.3, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1853.93, 3694.2, 34.2),
		textCoords = vector3(1853.93, 3694.2, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},

	--
	-- Paleto Bay
	--

	{
		textCoords = vector3(-432.185,5992.122,31.873),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.0,
				objCoords  = vector3(-432.185,5992.122,31.873),
			}
		}
	},
	{
		textCoords = vector3(-428.065,5996.672,31.873),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.0,
				objCoords  = vector3(-428.065,5996.672,31.873),
			}
		}
	},
	{
		textCoords = vector3(-431.192,5999.742,31.873),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		doors = {
			{
				objName = 'v_ilev_ph_cellgate',
				objYaw = 315.0,
				objCoords  = vector3(-431.192,5999.742,31.873),
			}
		}
	},

	--
	-- Bolingbroke Penitentiary

	-- Prison Solitary
	{
		objName = 'prop_ld_jail_door',
		objCoords  = vector3(1795.29, 2479.18, -122.55),
		textCoords = vector3(1795.29, 2479.18, -122.55),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 2,
		size = 2
	},
	-- Entrance (Two big gates)
	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1844.9, 2604.8, 44.6),
		textCoords = vector3(1844.9, 2608.5, 48.0),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 12,
		size = 2
	},

	{
		objName = 'prop_gate_prison_01',
		objCoords  = vector3(1818.5, 2604.8, 44.6),
		textCoords = vector3(1818.5, 2608.4, 48.0),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 12,
		size = 2
	},
	{
		textCoords = vector3(1811.93, 2481.66, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1813.75, 2488.90, 44.46)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1808.99, 2474.54, 44.47)
			}
		}
	},
	{
		textCoords = vector3(1755.42, 2423.73, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1749.05, 2419.75, 44.42)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1762.62, 2426.53, 44.43)
			}
		}
	},
	{
		textCoords = vector3(1660.42, 2409.59, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1652.98, 2409.57, 44.44)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1667.67, 2407.64, 44.42)
			}
		}
	},
	{
		textCoords = vector3(1555.35, 2476.5, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1550.93, 2482.74, 44.39)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1558.22, 2469.34, 44.39)
			}
		}
	},
	{
		textCoords = vector3(1548.29, 2583.77, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1546.98, 2576.13, 44.39)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1547.70, 2591.28, 44.50)
			}
		}
	},
	{
		textCoords = vector3(1580.92, 2672.84, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1584.65, 2679.75, 44.50)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1575.71, 2667.15, 44.50)
			}
		}
	},
	{
		textCoords = vector3(1655.7, 2744.44, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1648.40, 2741.66, 44.44)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1662.01, 2748.70, 44.44)
			}
		}
	},
	{
		textCoords = vector3(1769.22, 2748.99, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1776.70, 2747.15, 44.44)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1762.19, 2752.49, 44.44)
			}
		}
	},
	{
		textCoords = vector3(1831.97, 2695.89, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1830.13, 2703.49, 44.44)
			},

			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1835.28, 2689.10, 44.44)
			}
		}
	},
	{
		textCoords = vector3(1795.7, 2616.6, 46.44),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 15,
		size = 2,
		doors = {
			{
				objName = 'prop_gate_prison_01',
				objCoords = vector3(1799.61, 2616.97, 44.59)
			}
		}
	},
		--
	-- Mission Row Back
	--

	-- Back (double doors)
	{
		textCoords = vector3(468.6, -1014.4, 27.1),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_rc_door2',
				objYaw = 0.0,
				objCoords  = vector3(467.3, -1014.4, 26.5)
			},

			{
				objName = 'v_ilev_rc_door2',
				objYaw = 180.0,
				objCoords  = vector3(469.9, -1014.4, 26.5)
			}
		}
	},


	-- Back Gate
	{
		objName = 'hei_prop_station_gate',
		objYaw = 90.0,
		objCoords  = vector3(488.8, -1017.2, 27.1),
		textCoords = vector3(488.8, -1020.2, 30.0),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 14,
		size = 2
	},
	{
		objName = 'v_ilev_rc_door2',
		objYaw = -90.0,
		objCoords  = vector3(464.3, -983.9, 35.9),
		textCoords = vector3(464.3, -983.9, 35.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 2,
		size = 1
	},
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -240.0,
		objCoords  = vector3(1848.2, 3681.8, 34.2),
		textCoords = vector3(1848.2, 3681.8, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1845.7, 3688.4, 34.2),
		textCoords = vector3(1845.7, 3688.4, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1848.9, 3690.3, 34.2),
		textCoords = vector3(1848.9, 3690.3, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1,
		size = 1
	},

	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 30.0,
		objCoords  = vector3(1853.93, 3694.2, 34.2),
		textCoords = vector3(1853.93, 3694.2, 34.2),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1.5,
		size = 1
	},
	{
		objName = 'prop_ld_jail_door',
		objYaw = -114.0,
		objCoords  = vector3(620.9, -0.2, 43.9),
		textCoords = vector3(620.9, -0.2, 43.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1,
		size = 1
	},
	{
		objName = 'prop_ld_jail_door',
		objYaw = -114.0,
		objCoords  = vector3(619.9, -3.2, 43.9),
		textCoords = vector3(619.9, -3.2, 43.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1,
		size = 1
	},
	{
		objName = 'prop_ld_jail_door',
		objYaw = -114.0,
		objCoords  = vector3(618.3, -6.2, 43.9),
		textCoords = vector3(619.9, -6.2, 43.9),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 1,
		size = 1
	},
	
	--
	-- Mission Row Cells
	--

	-- Main Cells
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 0.0,
		objCoords  = vector3(463.8, -992.6, 24.9),
		textCoords = vector3(463.3, -992.6, 25.1),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	-- Cell 1
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = -90.0,
		objCoords  = vector3(462.3, -993.6, 24.9),
		textCoords = vector3(461.8, -993.3, 25.0),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	-- Cell 2
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.3, -998.1, 24.9),
		textCoords = vector3(461.8, -998.8, 25.0),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	-- Cell 3
	{
		objName = 'v_ilev_ph_cellgate',
		objYaw = 90.0,
		objCoords  = vector3(462.7, -1001.9, 24.9),
		textCoords = vector3(461.8, -1002.4, 25.0),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	}


}

