# Background

{ Sprite, Vector, BoundingBox } = require '../lib/instant-rocket-fuel/src/irf'

class BackgroundSprite

  constructor: (@eventManager, @keyboard) ->
    @debug    = false
    @type     = 'background'
    @size     = new Vector(576, 512)
    @mode     = 'day'
    @isMoving = true

    @sprite = new Sprite
      'texture': 'img/background.png'
      'width'  : @size.x
      'height' : @size.y
      'key'    :
        'day'  : 0
        'night': 1

    @coords = @size.div 2
    @speed  = new Vector(-0.005, 0.0)
    @hitbox = new BoundingBox(new Vector(@size.x // 2, -16),
                              new Vector(@size.x, 4))

    @eventManager.register('game:reset',     (sender) => @isMoving = false)
    @eventManager.register('bird:hitground', (sender) => @isMoving = false)
    @eventManager.register('bird:liftoff',   (sender) => @isMoving = true)

  onHit: (hitbox) ->
    # noop

  update: (delta) ->
    if @coords.x <= 0 then @coords.x = @size.x // 2
    if @isMoving then @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()
    @hitbox.render(ctx) unless @debug is false

module.exports = BackgroundSprite
