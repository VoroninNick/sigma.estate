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