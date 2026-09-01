player = {
    x = player_x,
    y = mobs_y,
    sprt = 64,
    stats = {
        hp = 100, -- health
        str = 2, -- strength
        def = 1, -- defense
        sta = 10, -- stamina
        guard = 10, -- guard life
        momentum = 0, -- boost
        clinch_ticks = 3 -- can be moved
    },
    draw = function(self)
        spr(self.sprt, 7 * 8, 5 * 8)
    end
}
player.__index = player

newbie = {
    x = rival_x,
    y = mobs_y,
    sprt = 64,
    stats = {
        hp = 100, -- health
        str = 2, -- strength
        def = 1, -- defense
        sta = 10, -- stamina
        guard = 10, -- guard life
        momentum = 0, -- boost
        clinch_ticks = 3 -- can be moved
    },
    draw = function(self)
        spr(self.sprt, 8 * 8, 5 * 8)
    end,
    seqs = {
        {nil, nil, nil, nil, nil, nil, nil}, -- Descanso total
        {movements.jab, movements.cross, movements.jab, movements.cross, movements.jab, movements.cross, movements.hook},
        {movements.jab, movements.cross, nil, nil, nil, nil, nil},
        {nil, movements.jab, movements.jab, movements.cross, nil, nil, nil},
        {movements.body, movements.body, movements.cross, nil, nil, nil, nil}
    }
}
newbie.__index = newbie

