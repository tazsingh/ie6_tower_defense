class HoverState < Bug
  def initialize window, ui, grid
    super window, ui, grid

    @speed = 1
    @colour = Gosu::yellow
    @health = 40 * @ui.level
  end
end