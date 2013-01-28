define_stage :win do

  curtain_up do
    create_actor :logo, x: 480, y: 360
    create_actor :label, text: "YOU WIN!", x: 150, y: 100, size: 90
    create_actor :label, text: "SCORE:", x: 40, y: 200, size: 90
    create_actor :label, text: backstage[:score], x: 300, y: 200, size: 90
  end

end

