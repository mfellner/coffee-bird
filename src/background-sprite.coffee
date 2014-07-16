# Background

{ Sprite, Vector } = require '../lib/instant-rocket-fuel/src/irf'

class BackgroundSprite

  constructor: ->
    @width  = 576
    @height = 512
    @mode   = 'day'

    @sprite = new Sprite
      'texture': 'img/background.png'
      'width'  : @width
      'height' : @height
      'key'    :
        'day'  : 0
        'night': 1

    @coords = new Vector(@width // 2, @height // 2)
    @speed  = new Vector(-0.05, 0.0)

  update: (delta) ->
    if @coords.x <= 0 then @coords.x = @width // 2
    @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()

module.exports = BackgroundSprite
