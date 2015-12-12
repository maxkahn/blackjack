class window.Bet extends Backbone.Model
  defaults: amount:0
  increase: ->
    currAmount = @get 'amount'
    @set 'amount', currAmount + 10
  decrease: ->
    currAmount = @get 'amount'
    if (currAmount - 10 >= 0)
      @set 'amount', currAmount - 10