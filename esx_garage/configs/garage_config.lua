-- esx_garage/configs/garage_config.lua

-- Configuration settings for the garage system
GarageConfig = {}

-- Cost of vehicle recovery
GarageConfig.RecoveryCost = 500 -- Example cost, can be adjusted as needed

-- List of garage locations without NPCs
GarageConfig.Locations = {
    {
        Visible = true,
        Type = 'car',
        Position = vector3(220.1418, -800.1686, 30.7227),
        SpawnPosition = vector4(229.3425, -801.4708, 30.5659, 161.8591),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(273.0, -343.85, 44.91),
        SpawnPosition = vector4(270.75, -340.51, 44.92, 342.03),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-71.46, -1821.83, 26.94),
        SpawnPosition = vector4(-66.51, -1828.01, 26.94, 235.64),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(1032.84, -765.1, 58.18),
        SpawnPosition = vector4(1023.2, -764.27, 57.96, 319.66),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-1248.69, -1425.71, 4.32),
        SpawnPosition = vector4(-1244.27, -1422.08, 4.32, 37.12),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-2961.58, 375.93, 15.02),
        SpawnPosition = vector4(-2964.96, 372.07, 14.78, 86.07),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(217.33, 2605.65, 46.04),
        SpawnPosition = vector4(216.94, 2608.44, 46.33, 14.07),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(1878.44, 3760.1, 32.94),
        SpawnPosition = vector4(1880.14, 3757.73, 32.93, 215.54),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(365.21, 295.6, 103.46),
        SpawnPosition = vector4(364.84, 289.73, 103.42, 164.23),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(1713.06, 4745.32, 41.96),
        SpawnPosition = vector4(1710.64, 4746.94, 41.95, 90.11),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(107.32, 6611.77, 31.98),
        SpawnPosition = vector4(110.84, 6607.82, 31.86, 265.28),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(328.6457, -210.4855, 54.0863),
        SpawnPosition = vector4(325.5470, -211.0033, 54.0863, 156.9495),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-176.8074, -1305.2096, 31.2980),
        SpawnPosition = vector4(-164.0872, -1306.4490, 31.3066, 9.2604),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(408.0792, -998.0554, 29.2663),
        SpawnPosition = vector4(408.0792, -998.0554, 29.2663, 50.8039),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(2422.3440, 4959.5835, 45.9706),
        SpawnPosition = vector4(2421.7756, 4959.3447, 46.0200, 44.8010),
        Interior = 'small'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-608.2778, -875.6619, 25.2812),
        SpawnPosition = vector4(-608.2778, -875.6619, 25.2812, 230.8461),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-1480.0311, -496.4789, 32.8068),
        SpawnPosition = vector4(-1480.0311, -496.4789, 32.8068, 215.6816),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-1667.8083, 72.3026, 63.5343),
        SpawnPosition = vector4(-1667.8083, 72.3026, 63.5343, 48.9008),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'car',
        Position = vector3(-387.9319, -107.0117, 38.6853),
        SpawnPosition = vector4(-387.9319, -107.0117, 38.6853, 215.1336),
        Interior = 'large'
    },
    {
        Visible = true,
        Type = 'air',
        Position = vector3(-1182.7245, -2852.9495, 14.0404),
        SpawnPosition = vector4(-1178.4406, -2845.8442, 13.9457, 333.0016),
    },
    {
        Visible = true,
        Type = 'boat',
        Position = vector3(-850.1674, -1498.1183, 1.6342),
        SpawnPosition = vector4(-844.0901, -1540.3718, -0.4741, 136.1160)
    },
}
