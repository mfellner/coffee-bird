# PillarSprite

{ Sprite, Vector, BoundingBox } = require '../lib/instant-rocket-fuel/src/irf'

class PillarSprite

  constructor: (@eventManager, @keyboard, @coords, @mode='btm') ->
    @debug = false
    @type  = 'pillar'
    @size  = new Vector(54, 320)

    @sprite = new Sprite
      'texture': 'img/pillar.png'
      'width'  : @size.x
      'height' : @size.y
      'key'    :
        'top': 0
        'btm': 1

    @isMoving = true
    @speed    = new Vector(-0.1, 0.0)
    @hitbox   = new BoundingBox(@coords, new Vector(@size.x - 2, @size.y))

    @eventManager.register('bird:hitground', (bird) => @isMoving = false)
    @eventManager.register('bird:liftoff',   (bird) => @isMoving = true)

  onHit: (hitbox, type) ->
    if type == 'bird'
      @eventManager.trigger('bird:hitpillar', this)

  update: (delta) ->
    if @coords.x <= 100 and not @scored
      @scored = true
      @eventManager.trigger('pillar:score', this)

    if @coords.x <= -@size.x // 2
      @eventManager.trigger('pillar:kill', this)

    if @isMoving then @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()
    @hitbox.render(ctx) unless @debug is false

module.exports = PillarSprite
