@TodoApp = React.createClass
  getInitialState: ->
    todos: this.props.todos

  create: (todo) ->
    this.setState todos: this.state.todos.concat(todo)

  render: ->
    `<div>
      <TodoList todos={this.state.todos} />
      <TodoForm onCreate={this.create} />
    </div>`

@TodoList = React.createClass
  render: ->
    `<ul>
        {this.props.todos.map(
           function(todo, index){
             return (<TodoItem key={index} id={todo.id} description={todo.description} completed_at={todo.completed_at} />)
           }, this)
         }
      </ul>`

@TodoItem = React.createClass
  getInitialState: ->
    {completed: this.props.completed_at?}

  handleChange: ->
    $.ajax(
      method: "PATCH"
      url: "/todos/#{this.props.id}/complete"
      success: =>
        this.setState completed: !this.state.completed
    )

  render: ->
    `<li>
      <label>
        <input type="checkbox" checked={this.state.completed} onChange={this.handleChange} />{this.props.description}
      </label>
    </li>`

@TodoForm = React.createClass
  handleSubmit: (e) ->
    e.preventDefault()
    form = React.findDOMNode(this.refs.todoForm)

    $.ajax
      method: "POST"
      url: "/todos"
      dataType: "JSON"
      data: $(form).serialize()
      success: (data) =>
        this.props.onCreate data
        React.findDOMNode(this.refs.description).value = ""

  render: ->
    `<form onSubmit={this.handleSubmit} ref="todoForm">
      <input name="utf8" type="hidden" value="✓"/>

      <div className="field">
        <input ref="description" type="text" name="todo[description]" id="todo_description" placeholder="I need to..." />
      </div>
    </form>`
