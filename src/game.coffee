# Game

{ Game
  Keyboard
  SceneManager
  EventManager
} = require '../lib/instant-rocket-fuel/src/irf'

class Game extends Game

  constructor: (params) ->
    super params
    @keyboard     = new Keyboard
    @eventManager = new EventManager
    @sceneManager.setScene "BackgroundScene", this

    @gameOver = false
    @gameOverKeyUp = 0

    @eventManager.register('game:over', (sender) =>
      @gameOver = true
      @eventManager.trigger('game:reset')
      @sceneManager.setScene "GameOverScene", this
    )

    # HACK TODO: refactor, move into own module
    onTouchStart = () =>
      @keyboard.keyarray['up'] = true

    onTouchStop = () =>
      @keyboard.keyarray['up'] = false

    cvs = document.getElementsByTagName('canvas')[0]
    cvs.addEventListener('touchstart', onTouchStart, false)
    cvs.addEventListener('touchend', onTouchStop, false)
    cvs.addEventListener('touchcancel', onTouchStop, false)
    cvs.addEventListener('touchleave', onTouchStop, false)

  update: (delta) ->
    super(delta)
    @fps = (1000 / delta).toFixed(1)

    if @gameOver && @keyboard.key('up')
      @gameOverKeyUp += 1
      if @gameOverKeyUp >= 30
        @gameOverKeyUp = 0
        @gameOver = false
        @sceneManager.setScene "BackgroundScene", this

    @sceneManager.currentScene.update delta

  render: ->
    super()
    @sceneManager.currentScene.render @ctx
    @ctx.fillText(@fps, @params.width - 50, 20)

module.exports = Game
