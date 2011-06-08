class Tile
  def initialize window, size, x, y, placeable
    @window = window
    @size = size
    @placeable = placeable
    @x = x
    @y = y

    @placed_tower = nil
    reset_colour
  end

  def place_tower tower
    if placeable? && @window.ui.apple_crack >= tower.cost
      @placed_tower = tower
      @window.ui.apple_crack -= @placed_tower.cost
      @placed_tower.placed = true
      @placed_tower.x = @x
      @placed_tower.y = @y
    end
  end

  def highlight
    @colour = Gosu::Color.argb(0xff99ff99) if placeable?
  end

  def update

  end

  def draw
    @window.draw_quad @x, @y, @colour,
                      @x + @size, @y, @colour,
                      @x + @size, @y + @size, @colour,
                      @x, @y + @size, @colour,
                      ZOrder::Grid

    @placed_tower.draw if @placed_tower

    reset_colour if placeable?
  end

  protected
  def placeable?
    @placeable
  end

  def reset_colour
    @colour = placeable? ? Gosu::Color.argb(0xff00dd00) : Gosu::gray
  end
end