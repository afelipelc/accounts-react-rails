@Record = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date  #record is received as prop from each record in records component
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)