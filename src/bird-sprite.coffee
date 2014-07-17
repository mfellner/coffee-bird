# Bird

{ Sprite, Vector, BoundingBox } = require '../lib/instant-rocket-fuel/src/irf'

class BirdSprite

  constructor: (@eventManager, @keyboard) ->
    @debug = false
    @size  = new Vector(34, 26)
    @mode  = 'red'

    @sprite = new Sprite
      'texture': 'img/bird.png'
      'width'  : @size.x
      'height' : @size.y
      'key'    :
        '00': 0
        'B0': 1
        'B1': 2
        'R0': 3
        'R1': 4
        'R2': 5
        'Y0': 6
        'Y1': 7
        'Y2': 8
        'B2': 9

    @sprite.addAnimation 'blue',
      'fps'   : 8
      'frames': [1, 2, 9]

    @sprite.addAnimation 'red',
      'fps'   : 8
      'frames': [3, 4, 5]

    @sprite.addAnimation 'yellow',
      'fps'   : 8
      'frames': [6, 7, 8]

    @maxSpeed  = 0.40
    @gravity   = 0.04
    @accelrtn  = 0.20
    @rotation  = 0.00
    @coords    = new Vector(100, 200)
    @speed     = new Vector(0.0, 0.0)
    @hitbox    = new BoundingBox(@coords, @size)

  setBlocked: (blocked) ->
    @isBlocked = blocked
    if @isBlocked then @speed.set(0, 0)

  # HACK TODO: refactor
  rotate: (delta) ->
    @rotation += delta
    if @rotation >= 1.5
      @rotation = 1.5
    else if @rotation <= -0.6
      @rotation = -0.6

  update: (delta) ->
    if (@keyboard.key('up') && (@speed.y >= -@maxSpeed))
      @speed.add_(new Vector(0.0, -@accelrtn))
      @rotate(-0.5)

    if (not @isBlocked)
      @speed.add_(new Vector(0.0, @gravity))
      @rotate(0.04)

    @coords.add_(@speed.mult delta)

  # HACK TODO: move into own module
  rotationMatrix: (theta) ->
    [Math.cos(theta), Math.sin(theta), -Math.sin(theta), Math.cos(theta)]

  render: (ctx) ->
    ctx.save()
    rot = @rotationMatrix(@rotation)
    ctx.transform(rot[0], rot[1], rot[2], rot[3], @coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()
    @hitbox.render(ctx) unless @debug is false

module.exports = BirdSprite
