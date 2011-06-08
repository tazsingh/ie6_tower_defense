require "gosu"
%w[z_order ui bug tower grid projectile].each do |r|
  require "./ie6_tower_defense/#{r}"
end

class IE6TowerDefense < Gosu::Window
  attr_reader :ui

  def initialize
    super 800, 600, false
    self.caption = "IE6 Tower Defense"

    @font = Gosu::Font.new self, Gosu::default_font_name, 20
    @ui = UI.new self
  end

  def update
    @ui.update
  end

  def draw
    @ui.draw
  end

  def needs_cursor?
    true
  end

  def button_down id
    case id
      when Gosu::Button::KbEscape
        close
    end
  end

  def button_up id
    case id
      when Gosu::Button::MsLeft
        @ui.place_tower
    end
  end
end

IE6TowerDefense.new.show