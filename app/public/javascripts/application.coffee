class App
  # App must be Singleton
  @instance = null
  @run: -> @instance || @instance = new App

  settings:
    search_path: -> '/search'

  # Initialization
  constructor: ->
    $('#search_form').submit @on_submit_form.bind(@)
    $('.date').datepicker
      format: 'yyyy-mm-dd'
      autoclose: true,
      toggleActive: true
      orientation: 'auto left'
    $document = $(document)
    $search_btn = $('#search_btn')
    $progressbar = $('#progressbar')
    # set global AJAX Observers
    $document.ajaxStart ->
      $search_btn.attr("disabled", true)
      $progressbar.removeClass('hidden')
    $document.ajaxComplete ->
      $search_btn.attr("disabled", false)
      $progressbar.addClass('hidden')

  # Search form logic
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
        that.draw_tables(response.data, '#content')
      .fail (response)->
        that.message(response.responseJSON.message, 'alert')
    false

  # Draw results in Tabs + Tables of Flights
  draw_tables: (data, container)->
    tab = []
    content = []
    first = true
    for date, results of data
      [tab_tpl, content_tpl] = @draw_tab(date, results, first)
      tab.push(tab_tpl)
      content.push(content_tpl)
      first = false if first

    tpl = """
      <ul class="nav nav-tabs" role="tablist">
        #{tab.join('')}
      </ul>
      <div class="tab-content">
        #{content.join('')}
      </div>
    """
    $(container).html(tpl)

  # Draw Tab and table of Flights
  draw_tab: (date, results, active)->
    flights = []
    for flight in results
      flights.push("""
        <tr>
          <td>
            <p>Airline: <label class="label label-success">#{flight.airline.name} (#{flight.airline.code})</label></p>
            <p>Plane: #{flight.plane.shortName}</p>
            <p>Flight number: #{flight.flightNum}</p>
          </td>
          <td>
            <p><strong>Departure</strong></p>
            <p>#{flight.start.airportName} (#{flight.start.airportCode})</p>
            <p>#{moment(flight.start.dateTime).format('YYYY-MM-DD, h:mm A')}</p>
          </td>
          <td>
            <p>Distance: #{flight.distance} km.</p>
            <p>Duration: #{moment.duration(flight.durationMin, 'minutes').humanize()}</p>
          </td>
          <td>
            <p><strong>Arrival</strong></p>
            <p>#{flight.finish.airportName} (#{flight.finish.airportCode})</p>
            <p>#{moment(flight.finish.dateTime).format('YYYY-MM-DD, h:mm A')}</p>
          </td>
          <td>
            <button class="btn btn-info">$#{flight.price} AUD</button>
          </td>
        </tr>
      """)

    tab_tpl = """
      <li role="presentation" class="#{'active' if active}"><a href="##{date}" data-toggle="tab">#{date}</a></li>
    """
    content_tpl = """
      <div class="tab-pane #{'active' if active}" role="tabpanel" id="#{date}">
        <table class="table table-striped table-hovered">
          #{flights.join('')}
        </table>
      </div>
    """
    [tab_tpl, content_tpl]

  # Display UI messages (errors etc)
  message: (msg, type = '')->
    @message_container ||= $('#message')
    return @message_container.html(msg) if type is ''
    @message_container.html("<div class='alert alert-danger'>#{msg}</div>")

$(document).ready -> App.run()
