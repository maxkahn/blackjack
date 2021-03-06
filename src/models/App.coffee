# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'playerMoney', new Bet({amount: 500})
    @set 'betMoney', new Bet()
    @set 'winMultiplier', 2
    @set 'betOpen', true
    @set 'historyGames', new HistoryGames()
