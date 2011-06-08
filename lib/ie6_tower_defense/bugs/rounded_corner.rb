class RoundedCorner < Bug
  def initialize window, ui, grid
    super window, ui, grid

    @speed = 0.8
    @colour = Gosu::cyan
    @health = 50 * @ui.level
  end
end