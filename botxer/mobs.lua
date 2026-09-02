player = {
    x = player_x,
    y = mobs_y,
    sprt = 64,
    stats = {
        hp = 100, -- health
        res_up = 10, -- resistence face
        res_body = 10, -- resistence body
        def_left = 10, -- resistence defense left arm
        def_right = 10, -- resistence defense right arm
        condition = 10, -- feets
        sta = 10, -- stamina

        str = 2, -- strength
        def = 1, -- defense
        spirit = 0, -- boost
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
        res_up = 10, -- resistence face
        res_body = 10, -- resistence body
        def_left = 10, -- resistence defense left arm
        def_right = 10, -- resistence defense right arm
        condition = 10, -- feets
        sta = 10, -- stamina

        str = 2, -- strength
        def = 1, -- defense
        spirit = 0, -- boost
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

