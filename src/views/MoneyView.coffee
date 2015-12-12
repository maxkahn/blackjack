class window.MoneyView extends Backbone.View
  initialize:->
    @model.on 'change', @render, @
    @render()
  render: ->
    currAmount = @model.get 'amount'
    @$el.html '<span>Player Money</span>'
    @$el.append '<p>'+currAmount+'</p>'
    @$el.append '<button class="add-button">+</button> <button class="remove-button">-</button>'