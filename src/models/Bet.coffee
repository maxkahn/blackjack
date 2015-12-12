class window.Bet extends Backbone.Model
  defaults: amount:0, incrementer: 10

  increase: ->
    currAmount = @get 'amount'
    @set 'amount', currAmount + @get('incrementer')
    
  decrease: ->
    currAmount = @get 'amount'
    if (currAmount - @get('incrementer') >= 0)
      @set 'amount', currAmount - @get('incrementer')

  finishBet: (playerWins, betAmount, multiplier) ->
    if playerWins
      @set 'amount', @get('amount') + (betAmount * multiplier)  