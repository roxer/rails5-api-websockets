#= require action_cable

@App = {}
App.cable = ActionCable.createConsumer()
# url = window.location.href
# arr = url.split("/")
# App.cable = ActionCable.createConsumer 'ws://localhost:28080/websocket'
# App.cable = ActionCable.createConsumer "ws://#{arr[2]}/websocket"
