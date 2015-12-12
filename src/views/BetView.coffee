class window.BetView extends Backbone.View
  initialize:->
    @model.on 'change', @render, @
    @render()
  render: ->
    currAmount = @model.get 'amount'
    @$el.html '<span>Bet Money</span>'
    @$el.append '<p>'+currAmount+'</p>'