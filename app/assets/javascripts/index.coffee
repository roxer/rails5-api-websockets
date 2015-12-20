#= require action_cable

@App = {}
App.cable = ActionCable.createConsumer 'ws://localhost:28080/websocket'
