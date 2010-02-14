require 'stage'
require 'ftor'
class WinStage < Stage

  def setup
    super
    spawn :logo, :x => 480, :y => 360
    spawn :label, :text => "YOU WIN!", :x => 150, :y => 100, :size => 90
    spawn :label, :text => "SCORE:", :x => 40, :y => 200, :size => 90
    spawn :label, :text => backstage[:score], :x => 300, :y => 200, :size => 90
  end

  def draw(target)
    target.fill [0]*3
    super
  end

end

