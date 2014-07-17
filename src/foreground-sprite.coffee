# Foreground

{ Sprite, Vector, BoundingBox } = require '../lib/instant-rocket-fuel/src/irf'

class ForegroundSprite

  constructor: ->
    @debug  = false
    @size   = new Vector(576, 112)
    @mode   = 'default'

    @sprite = new Sprite
      'texture': 'img/foreground.png'
      'width'  : @size.x
      'height' : @size.y
      'key'    :
        'default': 0

    @coords = new Vector(@size.x // 2, 456)
    @speed  = new Vector(-0.1, 0.0)
    @hitbox = new BoundingBox(@coords, @size)

  update: (delta) ->
    if @coords.x <= 0.0 then @coords.x = @size.x // 2
    @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()
    @hitbox.render(ctx) unless @debug is false

module.exports = ForegroundSprite
