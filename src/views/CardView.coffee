class window.CardView extends Backbone.View
  className: 'card'

  imageSrc: -> 
    suitName = @model.get 'suitName'
    rankName = @model.get 'rankName'
    rankName + "-" + suitName.toLowerCase() + ".png"

  template: _.template ''

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @model.attributes
    @$el.addClass 'covered' unless @model.get 'revealed'
    isRevealed = @model.get 'revealed'
    if isRevealed 
      @$el.css({"background-image": "url('img/cards/"+@imageSrc()+"')"})
