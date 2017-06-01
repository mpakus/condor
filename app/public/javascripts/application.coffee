class App
  # App must be Singleton
  @instance = null
  @run: -> @instance || @instance = new App

  settings:
    search_path: -> '/search'

  # initialization
  constructor: ->
    $('#search_form').submit @on_submit_form.bind(@)
    $('.date').datepicker
      format: 'yyyy-mm-dd'
      autoclose: true,
      toggleActive: true
      orientation: 'auto left'

  # search form logic
  on_submit_form: ->
    departure = $('#departure').val()
    destination = $('#destination').val()
    date = $('#date').val()
    that = @
    that.message('')

    if departure? or destination? or date?
      $.ajax
        url: @settings.search_path()
        data: { departure: departure, destination: destination, date: date }
      .done (response)->
        console.log response.responseJSON
      .fail (response)->
        that.message(response.responseJSON.message, 'alert')
    false

  # display UI messages (errors etc)
  message: (msg, type = '')->
    @message_container ||= $('#message')
    return @message_container.html(msg) if type is ''
    @message_container.html("<div class='alert alert-danger'>#{msg}</div>")

$(document).ready -> App.run()
