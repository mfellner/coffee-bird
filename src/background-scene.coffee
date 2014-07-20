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

    @parent.eventManager.register('pillar:kill', (pillar) =>
      @pillarArray.splice(@pillarArray.indexOf(pillar), 1)
      @addRandomPillar()
    )

    @init()
    @parent.eventManager.register('game:reset', () => @init())

  init: () ->
    @pillarArray = []
    @lastAddedLocation = {x:0, y:0}
    @addRandomPillar() for i in [0..4]

  randInt: (min, max) ->
    return Math.floor Math.random() * (max - min) + min

  addRandomPillar: ->
    location = if @randInt(0, 2) is 0 then 'top' else 'btm'
    y = if location is 'top' then @randInt(-130, -25) else @randInt(345, 530)
    offsetX = 54//2
    minX    = if @lastAddedCoords then @lastAddedCoords.x + offsetX else 0
    minX    = if location is not @lastAddedLocation then 0 else minX
    x       = offsetX + @randInt(minX, minX + offsetX)
    x       = if x < 288 + offsetX then 288 + offsetX else x

    coords = new Vector(x, y)
    @lastAddedCoords   = coords
    @lastAddedLocation = location

    pillar = new PillarSprite(@parent.eventManager,
                              @parent.keyboard,
                              coords,
                              location)
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
