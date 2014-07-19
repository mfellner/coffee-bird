# Intro Scene

{ Scene, Vector } = require '../lib/instant-rocket-fuel/src/irf'
BackgroundSprite       = require './background-sprite'
ForegroundSprite       = require './foreground-sprite'
BirdSprite             = require './bird-sprite'
PillarSprite           = require './bapillar-sprite'

class GameOverScene extends Scene

  constructor: (@parent) ->
    @sprites =
      background: new BackgroundSprite(@parent.eventManager, @parent.keyboard)
      foreground: new ForegroundSprite(@parent.eventManager, @parent.keyboard)

  update: (delta) ->
    # noop

  render: (ctx) ->
    @sprites.background.render(ctx)
    @sprites.foreground.render(ctx)
    ctx.fillText('GAME OVER', 90, 100)
    ctx.fillText('POINTS: ' + @parent.points, 100, 120)

module.exports = GameOverScene
