@Record = React.createClass
  handleDelete: (e) ->
    e.preventDefault
    #yeah... jQuery doesn't have a $.delete shorcut method
    $.ajax
      method: 'DELETE'
      url: "/records/#{ @props.record.id }"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record #handleDeleteRecord lo recibe como propiedad, por lo tanto se invoca al eliminar el registro
  render: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date  #record is received as prop from each record in records component
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'