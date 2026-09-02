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
        newbie.sprt = 64
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
    if p and o then
        player.sprt = p.mob_sprite
        newbie.sprt = o.mob_sprite
        local dmg = 0
        if (ispunch(p.type)) then 
            if (ispunch(o.type)) then
                dmg = calculation_base_damage(player.dmg, p.dmg, p.mult)
                do_damage(newbie, dmg)
                dmg = calculation_base_damage(newbie.dmg, o.dmg, o.mult)
                do_damage(player, dmg)

                if (isbody(o.nm)) then
                    reduce_body(player)
                end 
                if (isbody(p.nm)) then
                    reduce_body(newbie)
                end 
                return
            end
            
            if (ispower(o.type)) then
                dmg = calculation_base_damage(newbie.dmg, o.dmg, o.mult)
                do_damage(player, dmg)
                return
            end
            
            if (isblock(o.type)) then

            end
            
            if (isdodge(o.type)) then
                reduce_stamina(player)
                return 
            end

            if (isparry(o.type)) then
                dmg = calculation_actions(player.dmg+1, p.dmg , o.mult)
                reduce_stamina(player)
                do_damage(player, dmg)
                return
            end
            return
        end

            
        return
    end
    if p then
        player.sprt = p.mob_sprite
        if (isblock(p.type) or isdodge(p.type) or isparry(p.type)) then
            reduce_stamina(player)
            return
        end

        local dmg = calculation_base_damage(player.dmg, p.dmg, p.mult)
        do_damage(newbie, dmg)
        return
    end

    if o then
        newbie.sprt = p.mob_sprite
        if (isblock(o.type) or isdodge(o.type) or isparry(o.type)) then
            reduce_stamina(newbie)
            return
        end

        local dmg = calculation_base_damage(newbie.dmg, o.dmg, o.mult)
        do_damage(player, dmg)
        return
    end
end