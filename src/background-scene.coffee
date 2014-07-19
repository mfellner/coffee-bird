# Intro Scene

{ Scene, Vector } = require '../lib/instant-rocket-fuel/src/irf'
BackgroundSprite       = require './background-sprite'
ForegroundSprite       = require './foreground-sprite'
BirdSprite             = require './bird-sprite'
PillarSprite           = require './bapillar-sprite'

class BackgroundScene extends Scene

  constructor: (@parent) ->
    @sprites =
      background: new BackgroundSprite(@parent.eventManager, @parent.keyboard)
      foreground: new ForegroundSprite(@parent.eventManager, @parent.keyboard)
      bird:       new BirdSprite(@parent.eventManager, @parent.keyboard)

    # @spriteArray = (s for n, s of @sprites)
    @pillarArray = []

    # init pillars
    @addRandomPillar(i) for i in [0..2]

    @parent.eventManager.register('pillar:kill', (pillar) =>
      @pillarArray.splice(@pillarArray.indexOf(pillar), 1)
      @addRandomPillar()
    )

   randInt: (min, max) ->
    return Math.floor Math.random() * (max - min) + min

  addRandomPillar: (i=0) ->
    y = @randInt(300, 500)
    rndX = @randInt(54*i, 54*i*3)
    console.log('rndX', rndX)
    x = (288 + (54 // 2)) + rndX
    coords = new Vector(x, y)

    pillar = new PillarSprite(@parent.eventManager,
                              @parent.keyboard,
                              coords,
                              'btm')
    @pillarArray.push pillar

  update: (delta) ->
    @checkHit(@sprites.bird, @sprites.foreground)
    @checkHit(@sprites.bird, @sprites.background)

    for pillar in @pillarArray
      @checkHit(@sprites.bird, pillar)

    @sprites.background.update(delta)
    @sprites.foreground.update(delta)
    @sprites.bird.update(delta)

    for pillar in @pillarArray
      pillar.update(delta)

  render: (ctx) ->
    @sprites.background.render(ctx)

    for pillar in @pillarArray
      pillar.render(ctx)

    @sprites.foreground.render(ctx)
    @sprites.bird.render(ctx)

  checkHit: (a, b) ->
    if a.hitbox.intersect b.hitbox
      a.onHit(b.hitbox, b.type)
      b.onHit(a.hitbox, a.type)

module.exports = BackgroundScene
