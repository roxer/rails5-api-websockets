#// Place all the behaviors and hooks related to the matching controller here.
#// All this logic will automatically be available in application.js.
#= require action_cable

App.messages = App.cable.subscriptions.create { channel: "DiagramChannel", diagram_id: "1" },
  received: (data) ->
    @appendLine(data)

  appendLine: (data) ->
    html = @createLine(data)
    $( "#mess" ).prepend(html)
    $( "article:hidden:first" ).fadeIn( "slow" );

  createLine: (data) ->
    data_p = JSON.parse(data)
    event = data_p.action.event || 'default'
    action = JSON.stringify(data_p.action)
    body = JSON.stringify(data_p.body)
    console.log action
    
    bgcolor = switch
      when event == 'deleted' then '#F7EDED'
      when event == 'created' then '#EBF7F0'
      when event == 'updated' then '#FCF6DB'
      else 'white'

    """
    <article class="chat-line" style="display:none;background:#{bgcolor}">
      <span class="action">#{action}</span>
      <span class="body">#{body}</span>
    </article>
    """
