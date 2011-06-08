class FloatingElement < Bug
  def initialize window, ui, grid
    super window, ui, grid

    @speed = 1
    @colour = Gosu::blue
    @health = 60 * @ui.level
  end
end