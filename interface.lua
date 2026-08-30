function draw_boxing_ring()
    for i=0, 2 do 
        spr(lc, starting_point_x_l+(i*single_tile), starting_point_y-(i*single_tile))
        spr(rc, starting_point_x_r-(i*single_tile), starting_point_y-(i*single_tile))
        for n=0, 2 do 
            rectfill(
                starting_point_x_l+(i*single_tile)+single_tile,
                starting_point_y-(i*single_tile),
                starting_point_x_r-(i*single_tile),
                starting_point_y-(i*single_tile)+single_tile,
                12
        )
        end
    end
    rectfill(
        starting_point_x_l,
        7*single_tile,
        starting_point_x_r+single_tile,
        8*single_tile,
        1)
    player:draw()
    newbie:draw()
    graveyard_btn:draw()
    play_btn:draw()
    draw_deck_size()
end

function draw_columns()
  --left column
  rectfill(0, 0, 3 * single_tile, 8 * single_tile, 2)
  --right column
  rectfill(13 * single_tile, 0, 16 * single_tile - 1, 8 * single_tile, 3)
end

function draw_mouse()
  rect(mx, my, mx+2, my, 9)
  rect(mx, my, mx, my+2,9)
end

function draw_gy()
  rectfill(4, 4, 120, 120, 0)
  close_btn:draw()

  local y = 0
  local x = 0
  for i = 1, #gy do
    gy[i].x = 6 + (x * 16)
    gy[i].y = 12 + (y * 24)
    gy[i]:draw()

    x += 1
    if x == 7 then
      x = 0
      y += 1
    end
  end
end

function draw_deck_size()
    spr(19, 32, 0)
    print(#deck, 40, 2, 7)
end