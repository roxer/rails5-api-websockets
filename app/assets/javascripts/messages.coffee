#// Place all the behaviors and hooks related to the matching controller here.
#// All this logic will automatically be available in application.js.
#= require action_cable

App.messages = App.cable.subscriptions.create { channel: "DiagramChannel", diagram_id: "1" },
  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $("#mess").prepend(html)

  createLine: (data) ->
    data_p = JSON.parse(data)
    action = JSON.stringify(data_p.action)
    body = JSON.stringify(data_p.body)
    console.log action
    
    """
    <article class="chat-line">
      <span class="action">#{action}</span>
      <span class="body">#{body}</span>
    </article>
    """
