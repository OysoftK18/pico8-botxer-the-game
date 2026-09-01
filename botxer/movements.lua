movements = {
    jab = {
        nm = "jab", dmg = 1, multiplier = 1,
        card_sprite = 128, mob_sprite = 96,
        type = "punch",
        trigger_condition = "none",
        boosts = "power" -- marca: el
    }, -- siguiente power x1.5

    cross = {
        nm = "cross", dmg = 3, multiplier = 1.5,
        card_sprite = 168, mob_sprite = 97,
        type = "power",
        trigger_condition = "marked"
    },

    hook = {
        nm = "hook", dmg = 3, multiplier = 2,
        card_sprite = 130, mob_sprite = 96,
        type = "power",
        trigger_condition = "chin_up"
    },

    uppercut = {
        nm = "uppercut", dmg = 3, multiplier = 1,
        card_sprite = 132, mob_sprite = 98,
        type = "power",
        trigger_condition = "blocked",
        boosts = "chin_up" -- ignora
    }, -- bloqueo alto

    body = {
        nm = "body", dmg = 1, multiplier = 1,
        card_sprite = 134, mob_sprite = 112,
        type = "punch",
        trigger_condition = "none",
        boosts = "guard_low"
    },

    dodge = {
        nm = "dodge", multiplier = .5,
        card_sprite = 162, mob_sprite = 82,
        type = "dodge",
        trigger_condition = "hit",
        boosts = "punch"
    },

    block = {
        nm = "block", multiplier = .2,
        card_sprite = 160, mob_sprite = 80,
        type = "block",
        trigger_condition = "hit"
    },

    parry = {
        nm = "parry", multiplier = 0,
        card_sprite = 164, mob_sprite = 96,
        type = "parry",
        trigger_condition = "punch",
        boosts = "power"
    },

    feint = {
        nm = "feint", multiplier = 1,
        card_sprite = 166, mob_sprite = 66,
        type = "feint",
        trigger_condition = "defense"
    },

    clinch = {
        nm = "clinch", multiplier = 1,
        card_sprite = 136, mob_sprite = 67,
        type = "utility",
        trigger_condition = "none"
    }
}

combos = {
    {
        seq = { "jab", "cross" },
        mult = 1.4, nm = "uno-dos"
    },

    {
        seq = { "jab", "jab", "cross" },
        mult = 1.8, nm = "jab ciego"
    },

    {
        seq = { "jab", "cross", "hook" },
        mult = 2, nm = "el clasico"
    },

    {
        seq = { "body", "hook" },
        mult = 1.7, nm = "cambio de nivel"
    },

    {
        seq = { "uppercut", "hook" }, 
        mult = 2.2, nm = "sacacorchos"
    },

    {
        seq = { "dodge", "cross" },
        mult = 2, nm = "contra"
    },

    {
        seq = { "parry", "jab", "cross" },
        mult = 2.5, nm = "castigo"
    },

    {
        seq = { "body", "body", "cross" },
        mult = 2.5, nm = "apagafuegos"
    }
}