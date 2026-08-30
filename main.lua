function _init()
  -- enable mouse
  init_mouse()
  init_deck(30)
  init_turn()
  for i = 1, 7 do
    placeholders[i] = placeholder:new({
      n = i,
      x = 4 + (i - 1) * 17,
      y = 72
    })
  end
  en_seq = {}
end

function _update()
  if isrunning then
    set_enemy_movements()
    timer_manager()
    return
  end
  update_card_selected()
  mouse_update()
end

function _draw()
  cls()

  draw_columns()
  draw_boxing_ring()
  draw_hand()
  draw_board()
  if show_gy then
    draw_gy()
  end
  if not isrunning then
    draw_mouse()
  end
  description_box:draw()
end

function set_enemy_movements()
  en_seq = rnd(newbie.seqs)
end