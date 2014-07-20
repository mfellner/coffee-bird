# Main

Game   = require './game'
jQuery = require '../node_modules/jquery/dist/jquery.js'

Game.addScene require './background-scene'
Game.addScene require './gameover-scene'
Game.addScene require './gamestart-scene'

# game.eventManager.on " map.finishedLoading", ->

jQuery(->
  canvas = document.getElementById('game-canvas')
  game = new Game
    canvas: canvas
    width:  288
    height: 512

  game.start()
)
