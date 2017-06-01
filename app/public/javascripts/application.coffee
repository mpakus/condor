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
    console.log @settings.search_path()
    @init_datepicker()

  init_datepicker: ->
    $('.date').forEach (e)->
      e.val('hell') unless e.val()?

    $('.date').datepicker
      format: 'mm/dd/yyyy'
      autoclose: true,
      toggleActive: true
      orientation: 'auto left'

$(document).ready -> App.run()
