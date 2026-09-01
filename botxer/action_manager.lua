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

function calculation_actions(p, o)
    if p and o then
        player.sprt = p.mob_sprite
        newbie.sprt = o.mob_sprite

        if (ispunch(p.type)) then 
            -- punch vs punch
            if (ispunch(o.type)) then
                player.stats.hp -= newbie.str * o.mult
                player.stats.sta -= 1

                newbie.stats.hp -= player.dmg * p.mult
                newbie.stats.sta -= 1
            end
            
            if (ispower(o.type)) then
                player.stats.hp -= newbie.dmg * 1.8
                player.stats.sta -= 2.5
            end
            
            if (isblock(o.type)) then
                player.stats.sta -= 1

                
                newbie.stats.hp -= player.dmg - newbie.defense
                newbie.stats.g -= 1
            end
            
            if (isdodge(o.type)) then
                player.stats.sta -= 1

                newbie.stats.sta += 1.5
                newbie.stats.momentum += 1.5
            end
        end
        return
    end
    if p then
        player.sprt = p.mob_sprite
        if (ispunch(p.type)) then 
            newbie.hp -= p.dmg
        end
        if (ispower(p.type)) then 
            newbie.hp -= p.dmg
        end
    end
    if o then
        newbie.sprt = o.mob_sprite
        if (o.type == "power" or o.type =="punch") then
            player.stats.health -= o.dmg
        end
        if (ispower(o.type)) then
                player.stats.hp -= newbie.dmg * 1.8
                player.stats.sta -= 2.5
        end
    end

    printh("pl health: " .. player.stats.health, "test")
    printh("op health: " .. newbie.stats.health, "test")
end


function ispunch(tp)
    return tp == "punch"
end

function ispower(tp)
    return tp == "power"
end

function isdodge(tp)
    return tp == "dodge"
end

function isblock(tp)
    return tp == "block"
end