class window.HistoryGamesView extends Backbone.View

  tagName: 'table'

  initialize: -> @listenTo @collection, 'add', @render

  render: -> 
    @$el.children().detach()
    @$el.html('<thead>
    <tr>
      <th>Player Hands</th>
      <th>Dealer Hands</th>
      <th>Amount Earned/Lost</th>
    </tr>
  </thead>')
    .append(@collection.map((game) -> new GameView({model: game}).render()))