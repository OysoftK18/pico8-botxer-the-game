current_frame = 0
current_movement = 1
isrunning = false

--each 30 frames = action (main controller)
function timer_manager()
    current_frame += 1

    if (current_frame == 10) then
        local playercard = nil
        local opponentcard = nil
        if placeholders[current_movement].card then
            playercard = placeholders[current_movement].card
        end

        if en_seq[current_movement] then
            opponentcard = en_seq[current_movement]
        end

        calculation_actions(playercard, opponentcard)
        update_action_playing(current_movement)
        return
    end

    if (current_frame == 20) then
        player.sprt = 64
        enemy.sprt = 64
        current_movement += 1
        current_frame = 0
    end

    if (current_movement > #placeholders) then
        reset_action_manager()
        reset_board()
        init_turn()
    end
end

function reset_action_manager()
    current_frame = 0
    current_movement = 1
    isrunning = false
end

function reset_board()
    for placeholder in all(placeholders) do
        if placeholder.card then
            add(gy, placeholder.card)
        end
        placeholder.card = nil
    end
end

function update_action_playing(i)
    if (placeholders[i] != nil) then
        select.x = placeholders[i].x
        select.y = placeholders[i].y
    else
        select.x = 0
        select.y = 0
    end
end
--Missing clinch logic also other scenarios
function calculation_actions(p, o)
    if p and not o then
        -- Solo Player Attacks
        if ispunch(p.type) or ispower(p.type) then
            local dmg = calculation_base_damage(player.stats.str, p.dmg, p.mult)
            do_damage(enemy, dmg)
            if isbody(p.nm) then reduce_body(enemy) end

            -- Solo Player Defenses / Actions (whiffed defense costs stamina)
        elseif isdodge(p.type) or isblock(p.type) or isparry(p.type) then
            reduce_stamina(player)
        end
        return
    end

    if o and not p then
        -- Solo Enemy Attacks
        if ispunch(o.type) or ispower(o.type) then
            local dmg = calculation_base_damage(enemy.stats.str, o.dmg, o.mult)
            do_damage(player, dmg)
            if isbody(o.nm) then reduce_body(player) end

            -- Solo Enemy Defenses / Actions (whiffed defense costs stamina)
        elseif isdodge(o.type) or isblock(o.type) or isparry(o.type) then
            reduce_stamina(enemy)
        end
        return
    end
    
    local p_def = isdodge(p.type) or isblock(p.type) or isparry(p.type)
    local o_def = isdodge(o.type) or isblock(o.type) or isparry(o.type)

    if p_def and o_def then
        reduce_stamina_both()
        return
    end

    -- B. Power vs Power (Intended clash)
    if ispower(p.type) and ispower(o.type) then
        local combined_str = player.stats.str + enemy.stats.str
        local dmg = calculation_base_damage(combined_str, o.dmg, o.mult)
        do_damage(player, dmg)
        do_damage(enemy, dmg)
        return
    end

    -- C. Resolved Actions (Attacker vs Defender/Counter)
    local function evaluate_attack(atk_move, def_move, attacker, defender)
        -- Punch vs Punch
        if ispunch(atk_move.type) and ispunch(def_move.type) then
            local dmg = calculation_base_damage(attacker.stats.str, atk_move.dmg, atk_move.mult)
            do_damage(defender, dmg)
            if isbody(atk_move.nm) then reduce_body(defender) end

            -- Power vs Punch (Power user hits, Punch user gets beat out)
        elseif ispower(atk_move.type) and ispunch(def_move.type) then
            local dmg = calculation_base_damage(attacker.stats.str, atk_move.dmg, atk_move.mult)
            do_damage(defender, dmg)

            -- Attack vs Dodge
        elseif (ispunch(atk_move.type) or ispower(atk_move.type)) and isdodge(def_move.type) then
            reduce_stamina(attacker)

            -- Attack vs Parry
        elseif (ispunch(atk_move.type) or ispower(atk_move.type)) and isparry(def_move.type) then
            local dmg = calculation_actions(defender.stats.str + 1, def_move.dmg, def_move.mult)
            reduce_stamina(defender)
            do_damage(attacker, dmg)

            -- Attack vs Block
        elseif (ispunch(atk_move.type) or ispower(atk_move.type)) and isblock(def_move.type) then
            -- calculate_defense(attacker, defender, atk_move, def_move)
        end
    end

    -- Run symmetrically for both sides
    evaluate_attack(p, o, player, enemy)
    evaluate_attack(o, p, enemy, player)
end

local function resolve_combat(p, o, player, enemy)
    -- 1. Defenses vs Defenses
    local p_def = isdodge(p.type) or isblock(p.type) or isparry(p.type)
    local o_def = isdodge(o.type) or isblock(o.type) or isparry(o.type)

    if p_def and o_def then
        reduce_stamina_both()
        return
    end

    -- 2. Power vs Power (Intended clash)
    if ispower(p.type) and ispower(o.type) then
        local combined_str = player.stats.str + enemy.stats.str
        local dmg = calculation_base_damage(combined_str, o.dmg, o.mult)
        do_damage(player, dmg)
        do_damage(enemy, dmg)
        return
    end

    -- 3. Resolve Attacker (p) vs Defender/Counter (o)
    local function evaluate_attack(atk_move, def_move, attacker, defender)
        if ispunch(atk_move.type) and ispunch(def_move.type) then
            local dmg = calculation_base_damage(attacker.stats.str, atk_move.dmg, atk_move.mult)
            do_damage(defender, dmg)
            if isbody(atk_move.nm) then reduce_body(defender) end
        elseif ispunch(atk_move.type) and ispower(def_move.type) then
            -- Intended: Power beats Punch completely
            local dmg = calculation_base_damage(defender.stats.str, def_move.dmg, def_move.mult)
            do_damage(attacker, dmg)
        elseif isdodge(def_move.type) and (ispunch(atk_move.type) or ispower(atk_move.type)) then
            reduce_stamina(attacker)
        elseif isparry(def_move.type) and (ispunch(atk_move.type) or ispower(atk_move.type)) then
            local dmg = calculation_actions(defender.stats.str + 1, def_move.dmg, def_move.mult)
            reduce_stamina(defender)
            do_damage(attacker, dmg)
        end
    end

    -- Run interaction symmetrically
    evaluate_attack(p, o, player, enemy)
    evaluate_attack(o, p, enemy, player)
end