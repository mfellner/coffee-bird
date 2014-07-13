# Intro Scene

{ Scene
  Sprite
  Map
  Camera
  Vector
} = require '../lib/instant-rocket-fuel/src/irf'

class BackgroundScene extends Scene

  constructor: (@parent) ->
    super()
    @width = 288
    @height = 512
    @scrollSpeed = 0.25
    @isScrolling = true

    backgroundSprite = new Sprite
      'texture': 'img/bg-day.png'
      'width': @width
      'height': @height
      "key":
        "00": 0

    @background = new Map
      "mapFile": "img/3x1.png"
      "pattern": "simple"
      "sprite": backgroundSprite
      "ed": @parent.eventManager

    foregroundSprite = new Sprite
      'texture': 'img/bg-ground.png'
      'width': 288
      'height': 112
      "key":
        "00": 0

    @foreground = new Map
      "mapFile": "img/3x1.png"
      "pattern": "simple"
      "sprite": foregroundSprite
      "ed": @parent.eventManager

    @backgroundCamera = new Camera
      "projection": "normal"
      "vpWidth": @parent.params.width
      "vpHeight": @parent.params.height

    @foregroundCamera = new Camera
      "projection": "normal"
      "vpWidth": 288
      "vpHeight": 112

    @backgroundCamera.coor = new Vector(@width, @height // 2)
    @foregroundCamera.coor = new Vector(@width // 2, -344)

  update: (delta) ->
    if @backgroundCamera.coor.x is 2 * @width
      @backgroundCamera.coor.x = @width

    if @foregroundCamera.coor.x is 1.5 * @width
      @foregroundCamera.coor.x = @width

    if @isScrolling
      @backgroundCamera.coor.x += @scrollSpeed
      @foregroundCamera.coor.x += @scrollSpeed * 4

  render: (ctx) ->
    @backgroundCamera.apply ctx, =>
      @background.render(ctx, @backgroundCamera)

    @foregroundCamera.apply ctx, =>
      @foreground.render(ctx, @foregroundCamera)

module.exports = BackgroundScene
