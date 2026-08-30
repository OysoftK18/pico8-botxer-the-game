base = {
    x = 0,
    y = 0,
    w = 8,
    h = 8,
    new = function(self, tbl)
        tbl = tbl or {}
        -- cache del metatable, uno por clase
        if not rawget(self, "__mt") then
            self.__mt = { __index = self }
        end
        setmetatable(tbl, self.__mt)
        return tbl
    end,
    mouse_hit = function(self, mx, my)
        return (self.x < mx) and (self.w + self.x > mx) and (self.y < my) and (self.h + self.y > my)
    end
}

card = base:new({
    x = 0,
    y = 0,
    h = 20,
    w = 15,
    draw = function(self)
        spr(self.card_sprite, self.x, self.y, 2, 2)
        rect(self.x, self.y, self.x + self.w, self.y + self.h, 5)
    end
})
card.__index = card

placeholder = base:new({
    n = 0,
    h = 20,
    w = 15,
    card = nil, -- the card instance sitting here, or nil
    draw = function(self)
        if self.card then
            self.card.x, self.card.y = self.x, self.y
            self.card:draw()
        else
            rect(self.x, self.y, self.x + self.w, self.y + self.h, 5)
        end
        print(self.n, self.x + 1, self.y - 6, 6)
    end
})
placeholder.__index = placeholder

select = {
    x = 0, 
    y = 0, 
    h = 20,
    w = 15,
    draw = function (self)
        if (self.x != 0) then
            rect(self.x, self.y, self.x + self.w, self.y + self.h, 7)
        end
    end
}

--BTNS
graveyard_btn = base:new({
    x = 24, 
    y = 0,
    w = 8,
    h = 8,
    des = "graveyard",
    draw = function(self)
        spr(16, self.x, self.y)
    end
})

close_btn = base:new({
    x = 113, 
    y = 4,
    des = "close",
    draw = function(self)
        spr(17, self.x, self.y)
    end
})

play_btn = base:new({
    x = 96, 
    y = 0,
    w = 8,
    h = 8,
    des = "play",
    draw = function(self)
        spr(18, self.x, self.y)
    end
})

description_box = {
    x = 0,
    y = 0, 
    w = 0,
    h = 6,
    des = nil,
    draw = function(self)
        if (self.des) then
            rectfill(self.x, self.y, self.x + self.w, self.y + self.h, 7)
            print(self.des, self.x + 1, self.y+1, 0)
        end
    end
}