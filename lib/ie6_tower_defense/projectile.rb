class Projectile
  def initialize window, tower, x, y, colour, angle, speed, range, damage, hindrance = nil
    @window = window
    @tower = tower

    @angle = angle
    @speed = speed
    @range = range
    @damage = damage
    @hindrance = hindrance

    @x = x
    @y = y
    @colour = colour

    @time_til_destroy = @range / @speed
  end

  def update bugs
    if @time_til_destroy > 0
      bugs.each do |bug|
        if @x >= bug.left && @x + 5 <= bug.right && @y >= bug.top && @y + 5 <= bug.bottom
          bug.take_damage @damage, @hindrance
          @tower.remove_projectile self
          return
        end
      end

      @x += Gosu::offset_x(@angle, @speed)
      @y += Gosu::offset_y(@angle, @speed)
      @time_til_destroy -= 1
    else
      @tower.remove_projectile self
    end
  end

  def draw
    @window.draw_quad @x, @y, @colour,
                      @x + 5, @y, @colour,
                      @x + 5, @y + 5, @colour,
                      @x, @y + 5, @colour,
                      ZOrder::Projectile
  end
end