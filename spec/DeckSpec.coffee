assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()

  describe 'constructor', ->
    it 'should have 4 cards of any rank', ->
      deck = new Deck()
      tens = deck.filter((card) -> 10 is card.get 'rankName')
      assert.strictEqual tens.length, 4  

    it 'should have 13 cards of any suit', ->
      deck = new Deck()
      hearts = deck.filter((card) -> 'Hearts' is card.get 'suitName')
      assert.strictEqual hearts.length, 13

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 50
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 49

  describe 'dealPlayer', ->
    it 'should create a hand with two cards', ->
      assert.strictEqual hand.length, 2

    it 'should create a hand with all cards revealed', ->
      assert.strictEqual hand.every((card) -> card.get 'revealed'), true

  describe 'dealDealer', ->
    it 'should create a hand with two cards', ->
      dealer = deck.dealDealer()
      assert.strictEqual dealer.length, 2

    it 'should not create a hand with all cards revealed', ->
      dealer = deck.dealDealer()
      assert.strictEqual dealer.every((card) -> card.get 'revealed'), false

    it 'should flip the first card', ->
      dealer = deck.dealDealer()
      assert.strictEqual false, dealer.at(0).get 'revealed'      