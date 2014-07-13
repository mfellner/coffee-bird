# Game

{ Game
  SceneManager
  EventManager
} = require '../lib/instant-rocket-fuel/src/irf'

class Game extends Game

  constructor: (params) ->
    super params
    @eventManager = new EventManager
    @sceneManager.setScene "BackgroundScene", this

  update: (delta) ->
    super(delta)
    @fps = (1000 / delta).toFixed(1)
    @sceneManager.currentScene.update delta

  render: ->
    super()
    @sceneManager.currentScene.render @ctx
    @ctx.fillText(@fps, @params.width - 50, 20)

module.exports = Game
