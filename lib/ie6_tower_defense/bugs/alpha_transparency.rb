class AlphaTransparency < Bug
  def initialize window, ui, grid
    super window, ui, grid

    @speed = 1.2
    @colour = Gosu::white
    @health = 30 * @ui.level
  end
end