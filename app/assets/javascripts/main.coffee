# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.animate-input input').focus ->
    $(this).parent().addClass 'is-active is-completed'
    return
  $('.animate-input input').focusout ->
    if $(this).val() == ''
      $(this).parent().removeClass 'is-completed'
    $(this).parent().removeClass 'is-active'
    return