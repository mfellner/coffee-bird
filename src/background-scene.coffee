# Intro Scene

{ Scene, Map, Camera } = require '../lib/instant-rocket-fuel/src/irf'
BackgroundSprite       = require './background-sprite'
ForegroundSprite       = require './foreground-sprite'
BirdSprite             = require './bird-sprite'

class BackgroundScene extends Scene

  constructor: (@parent) ->
    @sprites =
      background: new BackgroundSprite(@parent.eventManager, @parent.keyboard)
      foreground: new ForegroundSprite(@parent.eventManager, @parent.keyboard)
      bird: new BirdSprite(@parent.eventManager, @parent.keyboard)

    @spriteArray = (s for n, s of @sprites)

  update: (delta) ->
    @checkHit(@sprites.bird, @sprites.foreground)
    @checkHit(@sprites.bird, @sprites.background)

    for sprite in @spriteArray
      sprite.update(delta)

  render: (ctx) ->
    for sprite in @spriteArray
      sprite.render(ctx)

  checkHit: (a, b) ->
    if a.hitbox.intersect b.hitbox
      a.onHit(b.hitbox, b.type)
      b.onHit(a.hitbox, a.type)

module.exports = BackgroundScene
