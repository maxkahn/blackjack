class window.GameView extends Backbone.View

  tagName: 'tr'

  initialize: ->

  render: ->
    playerView = new HandView(collection: @model.get('playerHand'))
    dealerView = new HandView(collection: @model.get('dealerHand'))

    @$el.children().detach()

    $playerNode = $('<td></td>')
    $playerNode.append(playerView.collection.map((card) -> 
      new CardView(model: card).render()))
    @$el.append($playerNode)

    $dealerNode = $('<td></td>')
    $dealerNode.append(dealerView.collection.map((card) -> 
      new CardView(model: card).render()))
    @$el.append($dealerNode)

    if @model.get('win')
      $scoreNode = $('<td>+</td>')
    else
      $scoreNode = $('<td>-</td>')
    $scoreNode.append(@model.get('score'))
    @$el.append($scoreNode)