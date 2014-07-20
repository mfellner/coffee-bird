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
    @sceneManager.setScene "GameStartScene", this

    @points = 0
    @gameOver = false
    @gameOverKeyUp = 0

    @eventManager.register('game:over', (sender) =>
      @gameOver     = true
      @keyUpCounter = 0
      @eventManager.trigger('game:reset')
      @sceneManager.setScene "GameOverScene", this
    )

    @eventManager.register('pillar:score', (pillar) => @points += 1)

    # HACK TODO: refactor, move into own module
    onTouchStart = () =>
      @keyUpCounter += 1
      @keyboard.keyarray['up'] = true
      el   = document.documentElement
      rfs  = el.requestFullScreen || el.webkitRequestFullScreen
      rfs = rel || el.mozRequestFullScreen
      rfs.call(el)

    onTouchStop = () =>
      @keyboard.keyarray['up'] = false

    cvs = document.getElementsByTagName('canvas')[0]
    cvs.addEventListener('touchstart',  onTouchStart, false)
    cvs.addEventListener('touchend',    onTouchStop,  false)
    cvs.addEventListener('touchcancel', onTouchStop,  false)
    cvs.addEventListener('touchleave',  onTouchStop,  false)

    @keyUpCounter = 0

    @keyboard.addEventListener('keyup', 'up', (event) =>
      @keyUpCounter += 1
    )

  start: () ->
    super()
    @eventManager.trigger('bird:liftoff', this)

  update: (delta) ->
    super(delta)
    @fps = (1000 / delta).toFixed(1)

    if @gameOver and @keyUpCounter >= 1
      @keyUpCounter = 0
      @gameOver = false
      @points = 0
      @sceneManager.setScene "GameStartScene", this, true

    @sceneManager.currentScene.update delta

  render: ->
    super()
    @sceneManager.currentScene.render @ctx
    if not @gameOver then @ctx.fillText('Points: ' + @points, 4, 20)
    # @ctx.fillText(@fps, @params.width - 50, 20)

module.exports = Game
