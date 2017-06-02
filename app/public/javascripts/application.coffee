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
    $document = $(document)
    $search_btn = $('#search_btn')
    $progressbar = $('#progressbar')
    $document.ajaxStart ->
      $search_btn.attr("disabled", true)
      $progressbar.removeClass('hidden')
    $document.ajaxComplete ->
      $search_btn.attr("disabled", false)
      $progressbar.addClass('hidden')

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
        that.draw_tables(response.data, '#content')
      .fail (response)->
        that.message(response.responseJSON.message, 'alert')
    false

  draw_tables: (data, container)->
    tab = content = []
    for date, results in data
      [tab_tpl, content_tpl] = @draw_tab(date, results)
      tab += tab_tpl
      content += content_tpl

    tpl = """
      <ul class="nav nav-tabs" role="tablist">
        #{tab.join()}
      </ul>

      <div class="tab-content">
        #{content.join()}
      </div>
    """
    $(container).html(tpl)

  draw_tab: (date, results)->
    tab_tpl = """
      <li role="presentation"><a href="##{date}" data-toggle="tab">#{date}</a></li>
    """
    content_tpl = """
      <div class="tab-pane" id="#{date}">...</div>
    """
    [tab_tpl, content_tpl]


  # display UI messages (errors etc)
  message: (msg, type = '')->
    @message_container ||= $('#message')
    return @message_container.html(msg) if type is ''
    @message_container.html("<div class='alert alert-danger'>#{msg}</div>")

$(document).ready -> App.run()
