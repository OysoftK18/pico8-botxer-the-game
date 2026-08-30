function init_mouse()
  poke(0x5f2d, 7)
  mouse_was_clicked = false
  current_action = nil
  current_sequence = nil
  show_gy = false
end

function mouse_update()
  mx = stat(32)
  my = stat(33)
  mb = (stat(34) & 1) == 1

  local m_clicked = mb and not mouse_was_clicked
  mouse_was_clicked = mb

  if m_clicked then
    --hand
    for c in all(hand) do
      if c:mouse_hit(mx, my) then
        current_action = c
        break
      end
    end

    --board
    for pl in all(placeholders) do
      if pl:mouse_hit(mx, my) then
        if (current_action != nil) then
          if (pl.card == nil) then
            current_action.cr = 5
            pl.card = current_action
            del(hand, current_action)
            current_action = nil

            set_card_position()
            break
          end
        end
        if (pl.card != nil) then
          current_action = nil
          add(hand, pl.card)
          pl.card = nil
        end
        break
      end
    end

    --buttons
    if graveyard_btn:mouse_hit(mx, my) then
      show_gy = true
    end
    if play_btn:mouse_hit(mx, my) and not show_gy then
      isrunning = true
    end
    if close_btn:mouse_hit(mx, my) then
      show_gy = false
    end
  end

  --description
  for c in all(hand) do
      if c:mouse_hit(mx, my) then
          description_box.des = c.nm
          description_box.x = mx + 3
          description_box.y = my + 3
          description_box.w = #c.nm * 4
          break
      else
          description_box.des = nil
      end
  end
end

function update_card_selected()
  if (current_action != nil) then
    select.x = current_action.x
    select.y = current_action.y
  else
    select.x = 0
    select.y = 0
  end
end