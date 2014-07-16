# Intro Scene

{ Scene, Map, Camera } = require '../lib/instant-rocket-fuel/src/irf'
BackgroundSprite       = require './background-sprite'
ForegroundSprite       = require './foreground-sprite'
BirdSprite             = require './bird-sprite'

class BackgroundScene extends Scene

  constructor: (@parent) ->
    console.log('new background-scene')
    @sprites = [ new BackgroundSprite
                 new ForegroundSprite
                 new BirdSprite ]

  update: (delta) ->
    for sprite in @sprites
      sprite.update(delta)

  render: (ctx) ->
    for sprite in @sprites
      sprite.render(ctx)

module.exports = BackgroundScene
