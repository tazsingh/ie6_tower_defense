class Tower
  attr_accessor :placed, :x, :y
  attr_reader :cost

  def initialize window
    @window = window

    @placed = false

    @range = 40.0
    @firing_speed = 1
    @damage = 10
    @cost = 10

    @x = @y = nil

    @projectiles = []
    @projectile_colour = Gosu::black

    @done_reloading_in = @reload_time = 100
  end

  def icon
    @icon ||= Gosu::Image.new @window, "../img/towers/#{self.class.name.downcase}2.png", true
  end

  def placed?
    @placed
  end

  def update bugs
    if placed?
      if @done_reloading_in <= 0
        index = 0
        fire_at = nil

        while fire_at.nil? && !bugs[index].nil?
          if Gosu::distance(bugs[index].center_x, bugs[index].center_y,
                            @x + (icon.width >> 1), @y + (icon.height >> 1)) <= @range
            fire_at = bugs[index]
          end
          index += 1
        end

        unless fire_at.nil?
          @projectiles << Projectile.new(@window, self,
                                         @x + (icon.width >> 1), @y + (icon.height >> 1), @projectile_colour,
                                         Gosu::angle(@x, @y, fire_at.x, fire_at.y), @firing_speed, @range, @damage, @hindrance)
          @done_reloading_in = @reload_time
        end
      else
        @done_reloading_in -= 1
      end
    end

    @projectiles.each {|p| p.update bugs }
  end

  def remove_projectile projectile
    @projectiles.delete projectile
  end

  def draw
    @icon.draw @x, @y, ZOrder::Tower
    @projectiles.each {|p| p.draw }
  end
end

%w[imac macbookpro macmini macpro].each do |tower|
  require "./ie6_tower_defense/towers/#{tower}"
end