class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('dealerHand').trigger('stand')

      playerScore = @model.get('playerHand').stand()
      dealerScore = @model.get('dealerHand').stand()

      if playerScore > 21
        console.log 'Dealer wins'
      else if dealerScore > 21
        console.log 'Player wins'
      else if playerScore == dealerScore
        console.log 'its a tie'
      else if playerScore > dealerScore
        console.log 'Player wins'
      else
        console.log 'Dealer wins'

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

