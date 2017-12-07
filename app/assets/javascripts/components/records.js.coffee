@Records = React.createClass
  getInitialState: ->
    records: @props.data #react trabaja con propiedades que se acumulan en la propiedad @state  => @state.propiedad (@state.records)
    #@props.data es lo que el componente recibe al ser invocado, desde index.html.erb se invocó a éste componente: react_component 'Records', {data: @records}
  getDefaultProps: -> 
    records: [] #si no hay datos iniciales entonces inicializar la propiedad, records es un array de registros
  addRecord: (record) -> #método que agregará el nuevo registro a la tabla
    #records = @state.records.slice() #El método slice no modifica. Devuelve una copia plana (shallow copy) de los elementos especificados del array original.
    #use React.addons
    records = React.addons.update(@state.records,{ $push: [record] } )
    @setState records: records #reasignar la lista registros
  #display panels with general info
  credits: -> #Calcula la suma de todos los saldos positivos (abonos)
    credits = @state.records.filter (val) -> val.amount > 0
    credits.reduce ((prev, curr) ->  #El método reduce() aplica una función a un acumulador y a cada valor de un array (de izquierda a derecha) para reducirlo a un único valor.
      prev + parseFloat(curr.amount)
    ), 0
  debits: -> #Calcula la suma de todos los saldos negativos (debits o cargos)
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->  #El método reduce() aplica una función a un acumulador y a cada valor de un array (de izquierda a derecha) para reducirlo a un único valor.
      prev + parseFloat(curr.amount)
    ), 0
  balance: -> #método que devuelve la suma del resultado de los métodos
    @debits() + @credits()
  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]] })
    @replaceState records: records
  deleteRecord: (record) -> #método que se encargará de eliminar el objeto del array
    #records = @state.records.slice() #removed after add addons
    index = @state.records.indexOf record
    #records.splice index, 1 #El metodo splice() cambia el contenido de un array eliminando elementos existentes y/o agregando nuevos elementos. array.splice(start, deleteCount, item1, item2, ...)
    #use React.addons
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records #reemplazar el status de records con el nuevo array
    #the main difference between setState and replaceState is that the first one will only update one key of the state object, the second one will completely override the current state of the component with whatever new object we send.
  render: ->  #todo componente React lleva un método render()
    React.DOM.div  #React.DOM.html_tag crea un nuevo nodo, ésto es como HAML donde vamos creando el árbol
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Records'
      #mostrar los páneles de información general
      React.DOM.div
        className: 'row'
        #Create elements sending props:values (go to AmountBox to see props used)
        React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credit'
        React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debit'
        React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance'
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
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for record in @state.records  #recorrido del arreglo de registros
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord  #invocar a la creación de un nuevo componente(pasandole las props) que devolverá la estructura de una fila con los datos del registro