# Intro Scene

{ Scene } = require '../lib/instant-rocket-fuel/src/irf'
BackgroundSprite       = require './background-sprite'
ForegroundSprite       = require './foreground-sprite'
BirdSprite             = require './bird-sprite'

class GameStartScene extends Scene

  constructor: (@parent) ->
    @sprites =
      background: new BackgroundSprite(@parent.eventManager, @parent.keyboard)
      foreground: new ForegroundSprite(@parent.eventManager, @parent.keyboard)
      bird:       new BirdSprite(@parent.eventManager, @parent.keyboard)

    @keyUpCounter = 0
    @isGameStart  = true

    # @parent.keyboard.addEventListener('keyup', 'up', @onKeyupEvent)
    @parent.eventManager.register('game:reset', () => @isGameStart = true)

  # onKeyupEvent: =>
  #   if @isGameStart
  #     @keyUpCounter += 1
  #   else
  #     @keyUpCounter = 0

  update: (delta) ->
    @keyUpCounter += 1 / delta
    if @keyUpCounter >= 2 and @isGameStart
      @keyUpCounter = 0
      @isGameStart  = false
      @parent.keyboard.removeEventListener('keyup', @onKeyupEvent)
      @parent.sceneManager.setScene "BackgroundScene", @parent

  render: (ctx) ->
    @sprites.background.render(ctx)
    @sprites.foreground.render(ctx)
    @sprites.bird.render(ctx)

module.exports = GameStartScene
