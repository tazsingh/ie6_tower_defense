class MacPro < Tower
  def initialize window
    super window

    @range = 70.0
    @projectile_colour = Gosu::black
    @damage = 30
    @firing_speed = 1
    @cost = 50
  end
end