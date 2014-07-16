# Bird

{ Sprite, Vector } = require '../lib/instant-rocket-fuel/src/irf'

class BirdSprite

  constructor: ->
    @width  = 34
    @height = 26
    @mode   = 'red'

    @sprite = new Sprite
      'texture': 'img/bird.png'
      'width'  : @width
      'height' : @height
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

    @coords = new Vector(100, 200)
    @speed  = new Vector(-0.0, 0.0)

  update: (delta) ->
    if @coords.x <= 0 then @coords.x = @width // 2
    @coords.add_(@speed.mult delta)

  render: (ctx) ->
    ctx.save()
    ctx.translate(@coords.x, @coords.y)
    @sprite.render(@mode, ctx)
    ctx.restore()

module.exports = BirdSprite
