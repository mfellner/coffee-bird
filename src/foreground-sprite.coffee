# Foreground

{ Sprite, Vector, BoundingBox } = require '../lib/instant-rocket-fuel/src/irf'

class ForegroundSprite

  constructor: (@eventManager, @keyboard) ->
    @debug    = true
    @type     = 'foreground'
    @size     = new Vector(576, 112)
    @mode     = 'default'
    @isMoving = true

    @sprite = new Sprite
      'texture': 'img/foreground.png'
      'width'  : @size.x
      'height' : @size.y
      'key'    :
        'default': 0

    @coords = new Vector(@size.x // 2, 456)
    @speed  = new Vector(-0.1, 0.0)
    @hitbox = new BoundingBox(@coords, @size)

    @eventManager.register('bird:hitground', (bird) => @isMoving = false)
    @eventManager.register('bird:liftoff',   (bird) => @isMoving = true)

  onHit: (hitbox) ->
    # noop

  update: (delta) ->
    if @coords.x <= 0.0 then @coords.x = @size.x // 2
    if @isMoving then @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()
    @hitbox.render(ctx) unless @debug is false

module.exports = ForegroundSprite
