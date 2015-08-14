# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
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