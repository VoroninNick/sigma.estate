# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#map = undefined
#mgr = undefined
#lat = $('#map_canvas').attr('data-lat')
#lng = $('#map_canvas').attr('data-lng')
#
#initialize = ->
#  myOptions =
#    zoom: 8
#    center: new (google.maps.LatLng)(lat, lng)
#    mapTypeId: google.maps.MapTypeId.ROADMAP
#  map = new (google.maps.Map)(document.getElementById('map_canvas'), myOptions)
#  mgr = new MarkerManager(map)
#  google.maps.event.addListener mgr, 'loaded', ->
#    i = 0
#    while i < 1000
#      marker = new (google.maps.Marker)(
#        position: new (google.maps.LatLng)(Math.random() * 180 - 90, Math.random() * 360 - 180)
#        title: 'Random marker #' + i)
#      mgr.addMarker marker, 0
#      i++
#    mgr.refresh()
#    return
#  return
#
#google.maps.event.addDomListener window, 'load', initialize




$.fn.observeMouseOut = (options)->
  $object = $(this)

  $(document).on 'mouseup', (event)->
    $containers = $object.filter(":visible")

    out_of_container = true
    in_container = !out_of_container
    $context_container = null
    $containers.each (index, element)->
      $element = $(element)
      cond1 = !$element.is(event.target)
      cond2 = $element.has(event.target).length is 0
      out_of_container = cond1 && cond2
      in_container = !out_of_container

      if out_of_container
        $context_container = $element
      else
        return false
    if out_of_container
      $containers.trigger('mouseUpOut')

$(document).ready ->
#
  options =
    bg: '#acf'
    target: document.getElementById('se-progress-bar')
    id: 'mynano'
  nanobar = new Nanobar(options)
  #move bar
  nanobar.go 30
  # size bar 30%
  # Finish progress bar
  nanobar.go 100


  $('.animate-input input, .animate-input textarea').focus ->
    $(this).parent().addClass 'is-active is-completed'
    return
  $('.animate-input input, .animate-input textarea').focusout ->
    if $(this).val() == ''
      $(this).parent().removeClass 'is-completed'
    $(this).parent().removeClass 'is-active'
    return



# turn off all animated buttons
  $('.b-turn-off.material-component.ripple button').click (e)->
    e.preventDefault()

#  $('#EnterFormModal').foundation('reveal', 'open')
#  $('#ResetPasswordFormModal').foundation('reveal', 'open')

#===========================================================
#  range slide initialize
#===========================================================
  if typeof $.fn.slider == 'function'

    $.fn.val_onkey_up = ()->
      $this = $(@)
      range_price = $this.find(".range-slide")

      $this.find('.rs-min').keyup ->
        range_price.slider("values", 0, @value)

      $this.find('.rs-max').keyup ->
        range_price.slider("values", 1, @value)

    $.fn.se_range_slider = ()->
      $this = $(@)
      $this_min = $this.find('.rs-min')
      $this_max = $this.find('.rs-max')
      range_price = $this.find(".range-slide")
      min_val = +range_price.attr('data-min-val')
      max_val = +range_price.attr('data-max-val')

      range_price.slider

        range: true
        min: min_val
        max: max_val
        values: [
          min_val
          max_val
        ]
        slide: (event, ui) ->
          # field min value
          $this_min.val ui.values[0]
          # field max value
          $this_max.val ui.values[1]
          return

      # set default value
      $this_min.val range_price.slider('values', 0)
      $this_max.val range_price.slider('values', 1)
      return

    $(".price-range-slider").se_range_slider()
    $(".price-range-slider").val_onkey_up()

    $(".square-range-slider").se_range_slider()
    $(".square-range-slider").val_onkey_up()

#===========================================================
#notification popup
#===========================================================
  $('body').on 'click', '.notification-link, .filter-block h5', (event)->
    $wrap = $(this).closest('.notification-wrap')
    $container = $wrap.find('.notification-container').filter(":not(:visible)")
    $container.fadeIn 300

  $notification_containers = $("div.notification-container")
  $('body').on "mouseUpOut", '.notification-container', ()->
    $containers = $(this)
    $containers.fadeOut duration: 300
  $notification_containers.observeMouseOut()

#===========================================================
# clear filters
#===========================================================
#  $('.catalog-page').on 'click', '.clear-filters a', () ->
#    alert 'clearf?'

#===========================================================
# expand filter block
#===========================================================
  $('.expand-filter-button').click ->
    $this = $(@).closest('.filter-block')
    if $this.hasClass('filter-block-expand')
      if !$this.hasClass('filter-block-expanded')
        $this.addClass('filter-block-expanded')
      else
        $this.removeClass('filter-block-expanded')

  $('.filter-block input[type="checkbox"]').click ->
    if $(@).is(':checked')
      console.log "top value ", $(@).closest('.filter-block').offset().top

# apartment one item
  $(".apartment-item-page ul.image-carousel").bxSlider()


  $(".best-apartment ul.ba-carousel").bxSlider()


  $(".similar-apartments ul.similar-apartments-carousel").bxSlider()



#
  $('.se-ajax-form input').focus ->
    $('.se-ajax-submit').hide()
    $this = $(@)
    $submit = $this.closest('.input').find('.se-ajax-submit')
    $submit.show()


#  $('.se-ajax-form input').focusout ->
#    $('.se-ajax-submit').hide()

  $('.se-ajax-form input[type=file]').change ->
    $(@).closest('form').submit()

#module A
#  class << self
#    attr_accessor :name
#    def test
#       @name = :test
#    end
#  end
#end
#
#class Book
#  class << self
#  def self.read_all
#end
#
#Book.read_all
#book.read


