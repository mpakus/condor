class App
  @instance = null
  # App is Singleton
  @run: -> @instance || @instance = new App

  settings:
    airlines_path: -> '/airlines'
    airports_path: -> '/airports'
    search_path: -> '/search'
    flight_search_path: (code) -> "/search/#{code}"

  constructor: ->
    @init_datepicker()
    @init_form()

  init_form: ->
    $('#search_form').submit @on_submit_form.bind(@)

  init_datepicker: ->
    $('.date').datepicker
      format: 'yyyy-mm-dd'
      autoclose: true,
      toggleActive: true
      orientation: 'auto left'

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
        console.log response
      .fail (response)->
        that.message(response.responseJSON.message, 'alert')
    false

  message: (msg, type = '')->
    @message_container ||= $('#message')
    return @message_container.html(msg) if type is ''
    @message_container.html("<div class='alert alert-danger'>#{msg}</div>")

$(document).ready -> App.run()
