OrderStatus.create(text: 'Pending - please wait.')
OrderStatus.create(text: 'Accepted - please send gold.')
OrderStatus.create(text: 'Processing - please wait.')
OrderStatus.create(text: 'Completed - check your inbox.')
OrderStatus.create(text: 'Rejected')

Permission.create(name: 'can_accept_orders')
Permission.create(name: 'can_process_orders')
Permission.create(name: 'can_view_stats')
Permission.create(name: 'can_manage_coins')
Permission.create(name: 'can_manage_news')

opt   = WorldType.create(name: 'Optional-PvP')
open  = WorldType.create(name: 'Open-PvP')
hard  = WorldType.create(name: 'Hardcore-PvP')
prev  = WorldType.create(name: 'Preview')

World.create(name: 'Aldora',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_480_000, rate: 0.0, world_type: open)
World.create(name: 'Amera',     location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_540_000, rate: 0.0, world_type: open)
World.create(name: 'Antica',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 120_000, rate: 0.0, world_type: open)
World.create(name: 'Arcania',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_520_000, rate: 0.0, world_type: open)
World.create(name: 'Askara',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_250_000, rate: 0.0, world_type: open)
World.create(name: 'Astera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_540_000, rate: 0.0, world_type: opt)
World.create(name: 'Aurea',     location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_360_000, rate: 0.0, world_type: open)
World.create(name: 'Aurera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 870_000, rate: 0.0, world_type: prev)
World.create(name: 'Aurora',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 100_000, rate: 0.0, world_type: prev)
World.create(name: 'Azura',     location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_050_000, rate: 0.0, world_type: open)
World.create(name: 'Balera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 4_390_000, rate: 0.0, world_type: open)
World.create(name: 'Berylia',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_380_000, rate: 0.0, world_type: open)
World.create(name: 'Calmera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_710_000, rate: 0.0, world_type: opt)
World.create(name: 'Candia',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_020_000, rate: 0.0, world_type: opt)
World.create(name: 'Celesta',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 940_000, rate: 0.0, world_type: opt)
World.create(name: 'Chimera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 6_760_000, rate: 0.0, world_type: open)
World.create(name: 'Danera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 5_240_000, rate: 0.0, world_type: open)
World.create(name: 'Danubia',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 480_000, rate: 0.0, world_type: open)
World.create(name: 'Dolera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 4_300_000, rate: 0.0, world_type: hard)
World.create(name: 'Elera',     location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_500_000, rate: 0.0, world_type: open)
World.create(name: 'Elysia',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_460_000, rate: 0.0, world_type: open)
World.create(name: 'Empera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 530_000, rate: 0.0, world_type: open)
World.create(name: 'Eternia',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 5_470_000, rate: 0.0, world_type: open)
World.create(name: 'Fidera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 500_000, rate: 0.0, world_type: opt)
World.create(name: 'Fortera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_000_000, rate: 0.0, world_type: open)
World.create(name: 'Furora',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_860_000, rate: 0.0, world_type: open)
World.create(name: 'Galana',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_430_000, rate: 0.0, world_type: open)
World.create(name: 'Grimera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 6_700_000, rate: 0.0, world_type: open)
World.create(name: 'Guardia',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_610_000, rate: 0.0, world_type: opt)
World.create(name: 'Harmonia',  location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_980_000, rate: 0.0, world_type: opt)
World.create(name: 'Hiberna',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_140_000, rate: 0.0, world_type: open)
World.create(name: 'Honera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 380_000, rate: 0.0, world_type: opt)
World.create(name: 'Inferna',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 4_400_000, rate: 0.0, world_type: hard)
World.create(name: 'Iridia',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 750_000, rate: 0.0, world_type: open)
World.create(name: 'Isara',     location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_090_000, rate: 0.0, world_type: open)
World.create(name: 'Jamera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_640_000, rate: 0.0, world_type: open)
World.create(name: 'Julera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_850_000, rate: 0.0, world_type: open)
World.create(name: 'Keltera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 5_220_000, rate: 0.0, world_type: open)
World.create(name: 'Kyra',      location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_560_000, rate: 0.0, world_type: open)
World.create(name: 'Libera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 200_000, rate: 0.0, world_type: open)
World.create(name: 'Lucera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_780_000, rate: 0.0, world_type: open)
World.create(name: 'Luminera',  location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 940_000, rate: 0.0, world_type: opt)
World.create(name: 'Lunara',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_770_000, rate: 0.0, world_type: open)
World.create(name: 'Magera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 15_920_000, rate: 0.0, world_type: opt)
World.create(name: 'Malvera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_040_000, rate: 0.0, world_type: open)
World.create(name: 'Menera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 0, rate: 0.0, world_type: opt)
World.create(name: 'Morgana',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_330_000, rate: 0.0, world_type: open)
World.create(name: 'Mythera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 4_560_000, rate: 0.0, world_type: open)
World.create(name: 'Nebula',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_230_000, rate: 0.0, world_type: open)
World.create(name: 'Neptera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 0, rate: 0.0, world_type: open)
World.create(name: 'Nerana',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_240_000, rate: 0.0, world_type: opt)
World.create(name: 'Nova',      location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 0, rate: 0.0, world_type: open)
World.create(name: 'Obsidia',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_040_000, rate: 0.0, world_type: open)
World.create(name: 'Ocera',     location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_790_000, rate: 0.0, world_type: open)
World.create(name: 'Olympa',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 580_000, rate: 0.0, world_type: opt)
World.create(name: 'Pacera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 30_000, rate: 0.0, world_type: opt)
World.create(name: 'Pandoria',  location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_990_000, rate: 0.0, world_type: open)
World.create(name: 'Premia',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_430_000, rate: 0.0, world_type: open)
World.create(name: 'Pythera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 0, rate: 0.0, world_type: open)
World.create(name: 'Refugia',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 840_000, rate: 0.0, world_type: opt)
World.create(name: 'Rubera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 480_000, rate: 0.0, world_type: open)
World.create(name: 'Samera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_160_000, rate: 0.0, world_type: open)
World.create(name: 'Saphira',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 4_250_000, rate: 0.0, world_type: open)
World.create(name: 'Secura',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_180_000, rate: 0.0, world_type: opt)
World.create(name: 'Selena',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 2_150_000, rate: 0.0, world_type: open)
World.create(name: 'Shanera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_710_000, rate: 0.0, world_type: open)
World.create(name: 'Shivera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 7_020_000, rate: 0.0, world_type: open)
World.create(name: 'Silvera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 7_040_000, rate: 0.0, world_type: open)
World.create(name: 'Solera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 5_010_000, rate: 0.0, world_type: open)
World.create(name: 'Tenebra',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 5_620_000, rate: 0.0, world_type: open)
World.create(name: 'Thoria',    location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_100_000, rate: 0.0, world_type: open)
World.create(name: 'Titania',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_520_000, rate: 0.0, world_type: open)
World.create(name: 'Trimera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_090_000, rate: 0.0, world_type: open)
World.create(name: 'Unitera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 270_000, rate: 0.0, world_type: opt)
World.create(name: 'Valoria',   location: 'EU', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 1_200_000, rate: 0.0, world_type: open)
World.create(name: 'Vinera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 3_650_000, rate: 0.0, world_type: open)
World.create(name: 'Xantera',   location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 6_800_000, rate: 0.0, world_type: open)
World.create(name: 'Xerena',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 4_230_000, rate: 0.0, world_type: open)
World.create(name: 'Zanera',    location: 'US', account: 1, blocked_for_incoming: false, blocked_for_outgoing: false, amount: 230_000, rate: 0.0, world_type: open)

# From Optional-PvP
Rate.create(from_world_type:  WorldType.find_by(name: 'Optional-PvP'),
            to_world_type:    WorldType.find_by(name: 'Optional-PvP'), rate: 0.35,
            reducible: true, reduction_step: 0.05)

Rate.create(from_world_type:  WorldType.find_by(name: 'Optional-PvP'),
            to_world_type:    WorldType.find_by(name: 'Open-PvP'),     rate: 0.8,
            reducible: true, reduction_step: 0.05)

Rate.create(from_world_type:  WorldType.find_by(name: 'Optional-PvP'),
            to_world_type:    WorldType.find_by(name: 'Hardcore-PvP'), rate: 2.0,
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Optional-PvP'),
            to_world_type:    WorldType.find_by(name: 'Preview'),      rate: 2.0,
            reducible: false, reduction_step: 0.0)

# From Open-PvP
Rate.create(from_world_type:  WorldType.find_by(name: 'Open-PvP'),
            to_world_type:    WorldType.find_by(name: 'Optional-PvP'), rate: 0.3,
            reducible: true, reduction_step: 0.05)

Rate.create(from_world_type:  WorldType.find_by(name: 'Open-PvP'),
            to_world_type:    WorldType.find_by(name: 'Open-PvP'),     rate: 0.35,
            reducible: true, reduction_step: 0.05)

Rate.create(from_world_type:  WorldType.find_by(name: 'Open-PvP'),
            to_world_type:    WorldType.find_by(name: 'Hardcore-PvP'), rate: 1.0,
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Open-PvP'),
            to_world_type:    WorldType.find_by(name: 'Preview'),      rate: 1.0,
            reducible: false, reduction_step: 0.0)


# From Hardcore-PvP
Rate.create(from_world_type:  WorldType.find_by(name: 'Hardcore-PvP'),
            to_world_type:    WorldType.find_by(name: 'Optional-PvP'), rate: -(1.0/3.0),
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Hardcore-PvP'),
            to_world_type:    WorldType.find_by(name: 'Open-PvP'),     rate: -(1.0/5.0),
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Hardcore-PvP'),
            to_world_type:    WorldType.find_by(name: 'Hardcore-PvP'), rate: 0.25,
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Hardcore-PvP'),
            to_world_type:    WorldType.find_by(name: 'Preview'),      rate: -(1.0/3.0),
            reducible: false, reduction_step: 0.0)


# From Preview
Rate.create(from_world_type:  WorldType.find_by(name: 'Preview'),
            to_world_type:    WorldType.find_by(name: 'Optional-PvP'), rate: -(1.0/5.0),
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Preview'),
            to_world_type:    WorldType.find_by(name: 'Open-PvP'),     rate: 0.0,
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Preview'),
            to_world_type:    WorldType.find_by(name: 'Hardcore-PvP'), rate: 1,
            reducible: false, reduction_step: 0.0)

Rate.create(from_world_type:  WorldType.find_by(name: 'Preview'),
            to_world_type:    WorldType.find_by(name: 'Preview'),      rate: 0.4,
            reducible: false, reduction_step: 0.0)
