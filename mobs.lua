player = {
    x = player_x,
    y = mobs_y,
    sprt = 64,
    stats = {
        health = 100,
        defense = 10,
        power = 2,
        speed = 2,
        stamina = 10,
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
        health = 100,
        defense = 10,
        power = 2,
        speed = 2,
        stamina = 10,
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

