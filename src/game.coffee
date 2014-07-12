# Game

class Game
  constructor: (@name) ->

  log: ->
    console.log('Hello, ' + @name + '!')

module.exports = Game
