# Intro Scene

{ Scene, Map, Camera } = require '../lib/instant-rocket-fuel/src/irf'
BackgroundSprite       = require './background-sprite'
ForegroundSprite       = require './foreground-sprite'
BirdSprite             = require './bird-sprite'

class BackgroundScene extends Scene

  constructor: (@parent) ->
    console.log('new background-scene')
    @sprites = [ new BackgroundSprite(@parent.eventManager, @parent.keyboard)
                 new ForegroundSprite(@parent.eventManager, @parent.keyboard)
                 new BirdSprite(@parent.eventManager, @parent.keyboard) ]

  update: (delta) ->
    # HACK TODO: refactor
    if @sprites[1].hitbox.intersect @sprites[2].hitbox
      @sprites[2].setBlocked true
    else
      @sprites[2].setBlocked false

    for sprite in @sprites
      sprite.update(delta)

  render: (ctx) ->
    for sprite in @sprites
      sprite.render(ctx)

module.exports = BackgroundScene
