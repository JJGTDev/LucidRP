Config = {}
Config.Locale = 'en'

Config.DoorList = {
	
	-- Entrance Doors
	{
		textCoords = vector3(434.7, -982.0, 31.5),
		authorizedJobs = { 'police', 'rescue' },
		locked = false,
		distance = 2.5,
		doors = {
			{
				objName = 'v_ilev_ph_door01',
				objYaw = -90.0,
				objCoords = vector3(434.7, -980.6, 30.8)
			},

			{
				objName = 'v_ilev_ph_door002',
				objYaw = -90.0,
				objCoords = vector3(434.7, -983.2, 30.8)
			}
		}
	},

	-- To locker room & roof
	{
		objName = 'v_ilev_ph_gendoor004',
		objYaw = 90.0,
		objCoords  = vector3(449.6, -986.4, 30.6),
		textCoords = vector3(450.1, -986.3, 31.7),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	-- Rooftop
	{
		objName = 'v_ilev_gtdoor02',
		objYaw = 90.0,
		objCoords  = vector3(464.3, -984.6, 43.8),
		textCoords = vector3(464.3, -984.0, 44.8),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	-- Hallway to roof
	{
		objName = 'v_ilev_arm_secdoor',
		objYaw = 90.0,
		objCoords  = vector3(461.2, -985.3, 30.8),
		textCoords = vector3(461.5, -986.0, 31.5),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},


	-- Captain Office
	{
		objName = 'v_ilev_ph_gendoor002',
		objYaw = -180.0,
		objCoords  = vector3(447.2, -980.6, 30.6),
		textCoords = vector3(447.2, -980.0, 31.7),
		authorizedJobs = { 'police', 'rescue' },
		locked = true
	},

	-- To downstairs (double doors)
	{
		textCoords = vector3(444.6, -989.4, 31.7),
		authorizedJobs = { 'police', 'rescue' },
		locked = true,
		distance = 4,
		doors = {
			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 180.0,
				objCoords = vector3(443.9, -989.0, 30.6)
			},

			{
				objName = 'v_ilev_ph_gendoor005',
				objYaw = 0.0,
				objCoords = vector3(445.32, -989.33, 30.6)
			}
		}
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
	}
}