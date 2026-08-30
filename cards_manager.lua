metas = {}  
gy = {}
placeholders = {}
deck = {}
hand = {}
nextid = 1

function meta_for(def)
    if not metas[def] then
        setmetatable(def, card)
        metas[def] = { __index = def }
    end
    return metas[def]
end
function make_card(def, props)
    local c = props or {}
    c.id = nextid
    nextid += 1
    return setmetatable(c, meta_for(def))
end


move_list = {}
for k, v in pairs(movements) do
    add(move_list, v)
end

function rnd_movement()
    return rnd(move_list)
end

function move(c, from, to)
    del(from, c)
    add(to, c)
end

function draw_card()
    local c = deck[#deck]
    if c then
        move(c, deck, hand)
    end
    return c
end

function init_deck(n)
    for i = 1, n do
        add(deck, make_card(rnd_movement()))
    end
end

function init_turn()
    for i = 0, 3 do
        if (#hand == 7) then
            break
        end
        if (#deck > 0) then
            draw_card()
        else
            refill_deck()
            draw_card()
        end
    end
    set_card_position()
end

function set_card_position()
    for i = 1, #hand do
        local c = hand[i]
        c.x = 4 + (i - 1) * 17
        c.y = 98
    end
end

function draw_hand()
    for c in all(hand) do
        c:draw()
    end
end

function draw_board()
  for i = 1, 7 do
    placeholders[i]:draw()
  end
  select:draw()
end

function refill_deck()
    for c in all(gy) do
        move(c, gy, deck)
    end
end