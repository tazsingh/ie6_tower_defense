class MacBookPro < Tower
  def initialize window
    super window

    @range = 90.0
    @projectile_colour = Gosu::aqua
    @damage = 10
    @firing_speed = 2
    @cost = 5
  end
end