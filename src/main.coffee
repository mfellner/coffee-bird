# Main

Game   = require './game'
jQuery = require '../node_modules/jquery/dist/jquery.js'

Game.addScene require './background-scene'

jQuery ->
  game = new Game
    "width" : 288
    "height": 512

  # game.eventManager.on "map.finishedLoading", ->
  game.start()
