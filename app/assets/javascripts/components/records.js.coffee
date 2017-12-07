@Records = React.createClass
  getInitialState: ->
    records: @props.data #react trabaja con propiedades que se acumulan en la propiedad @state  => @state.propiedad (@state.records)
    #@props.data es lo que el componente recibe al ser invocado, desde index.html.erb se invocó a éste componente: react_component 'Records', {data: @records}
  getDefaultProps: -> 
    records: [] #si no hay datos iniciales entonces inicializar la propiedad, records es un array de registros
  addRecord: (record) -> #método que agregará el nuevo registro a la tabla
    records = @state.records.slice() #El método slice no modifica. Devuelve una copia plana (shallow copy) de los elementos especificados del array original.
    records.push record
    @setState records: records #reasignar la lista registros
  render: ->  #todo componente React lleva un método render()
    React.DOM.div  #React.DOM.html_tag crea un nuevo nodo, ésto es como HAML donde vamos creando el árbol
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Records'
      #incovar al form para que se muestre arriba de la tabla
      React.createElement RecordForm, handleNewRecord: @addRecord #pasar handleNewRecord como parte de @props del form, handleNewRecord es la referencia al método responsable de agregar el nuevo registro
      React.DOM.hr null #genera un <hr>
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Amount'
        React.DOM.tbody null,
          for record in @state.records  #recorrido del arreglo de registros
            React.createElement Record, key: record.id, record: record  #invocar a la creación de un nuevo componente que devolverá la estructura de una fila con los datos del registro