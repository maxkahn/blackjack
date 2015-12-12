class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button> <button class="new-game-button">New Game</button>
    <div class = "end-game-message"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
    <div class="player-money-container"></div>
    <div class="player-bet-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> 
      @model.get('dealerHand').dealerPlay()

      playerScore = @model.get('playerHand').stand()
      dealerScore = @model.get('dealerHand').stand()

      playerWins = false
      if playerScore > 21
        playerWins = false
      else if dealerScore > 21
        playerWins = true
      else if playerScore == dealerScore
        playerWins = false
      else if playerScore > dealerScore
        playerWins = true
      else
        playerWins = false

      playerMoneyModel = @model.get('playerMoney')
      betMoneyModel = @model.get('betMoney')
      playerMoney = playerMoneyModel.get('amount')
      betMoney = betMoneyModel.get('amount')
      multiplier = @model.get('winMultiplier')
      if playerWins
        playerMoneyModel.set 'amount', playerMoney + (betMoney * multiplier)
      betMoneyModel.set('amount', 0)

      if playerWins
        console.log 'Player wins!'
        $('.end-game-message').removeClass('end-game-message').addClass('win')
        $('.win').text('You Win')
      else
        console.log 'Dealer wins'
        $('.end-game-message').removeClass('end-game-message').addClass('loss')
        $('.loss').text('You lose')

    'click .new-game-button': ->
      deck = new Deck()
      @model.set 'deck', deck
      @model.set 'playerHand', deck.dealPlayer()
      @model.set 'dealerHand', deck.dealDealer()
      @render()
      $('.end-game-message').removeClass('win loss').addClass('end-game-message')

    'click .add-button': -> 
      playerMoney = @model.get 'playerMoney'
      betMoney = @model.get 'betMoney'
      if 0 < playerMoney.get 'amount'
        betMoney.increase()
        playerMoney.decrease()
    'click .remove-button': -> 
      playerMoney = @model.get 'playerMoney'
      betMoney = @model.get 'betMoney'
      if 0 < betMoney.get 'amount'
        playerMoney.increase()
        betMoney.decrease()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
    @$('.player-money-container').html new MoneyView(model: @model.get 'playerMoney').el
    @$('.player-bet-container').html new BetView(model: @model.get 'betMoney').el
