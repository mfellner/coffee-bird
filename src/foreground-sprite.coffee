# Foreground

{ Sprite, Vector } = require '../lib/instant-rocket-fuel/src/irf'

class ForegroundSprite

  constructor: ->
    @width  = 576
    @height = 112
    @mode   = 'default'

    @sprite = new Sprite
      'texture': 'img/foreground.png'
      'width'  : @width
      'height' : @height
      'key'    :
        'default': 0

    @coords = new Vector(@width // 2, 456)
    @speed  = new Vector(-0.1, 0.0)

  update: (delta) ->
    if @coords.x <= 0 then @coords.x = @width // 2
    @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()

module.exports = ForegroundSprite
