function calculation_base_damage(str, dmg, mult)
    return str * dmg * mult
end

function do_damage(target, dmg)
    target.stats.hp -= dmg
end

function reduce_stamina(target)
    target.stats.sta -= 1
end

function reduce_body(target)
    target.stats.res_body -= 1
end

--Change damage done if unlucky TODO
function stamina_damage_mult(sta)
    if (sta >= 6 and sta <8) then
        return .8
    end

    if (sta > 2 and sta <=5) then
        return .6
    end

    if (sta <=2) then
        return .2
    end
end