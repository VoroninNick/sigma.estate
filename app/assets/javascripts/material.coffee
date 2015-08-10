##jQuery time
#parent = undefined
#ink = undefined
#d = undefined
#x = undefined
#y = undefined
#$('ul li a').click (e) ->
#  parent = $(this).parent()
#  #create .ink element if it doesn't exist
#  if parent.find('.ink').length == 0
#    parent.prepend '<span class=\'ink\'></span>'
#  ink = parent.find('.ink')
#  #incase of quick double clicks stop the previous animation
#  ink.removeClass 'animate'
#  #set size of .ink
#  if !ink.height() and !ink.width()
#    #use parent's width or height whichever is larger for the diameter to make a circle which can cover the entire element.
#    d = Math.max(parent.outerWidth(), parent.outerHeight())
#    ink.css
#      height: d
#      width: d
#  #get click coordinates
#  #logic = click coordinates relative to page - parent's position relative to page - half of self height/width to make it controllable from the center;
#  x = e.pageX - (parent.offset().left) - (ink.width() / 2)
#  y = e.pageY - (parent.offset().top) - (ink.height() / 2)
#  #set the position and add class .animate
#  ink.css(
#    top: y + 'px'
#    left: x + 'px').addClass 'animate'

$(document).ready ->
  #jQuery time
  parent = undefined
  ink = undefined
  d = undefined
  x = undefined
  y = undefined
  $('body').on 'click', '.ripple a, .ripple button', (e) ->
  #  parent = $(@).parent()
    parent = $(@).closest('.material-component')
    #create .ink element if it doesn't exist
    if parent.find('.ink').length == 0
      parent.prepend '<span class=\'ink\'></span>'
    ink = parent.find('.ink')
    #incase of quick double clicks stop the previous animation
    ink.removeClass 'animate'
    #set size of .ink
    if !ink.height() and !ink.width()
      #use parent's width or height whichever is larger for the diameter to make a circle which can cover the entire element.
      d = Math.max(parent.outerWidth(), parent.outerHeight())
      ink.css
        height: d
        width: d
    #get click coordinates
    #logic = click coordinates relative to page - parent's position relative to page - half of self height/width to make it controllable from the center;
    x = e.pageX - (parent.offset().left) - (ink.width() / 2)
    y = e.pageY - (parent.offset().top) - (ink.height() / 2)
    #set the position and add class .animate
    ink.css(
      top: y + 'px'
      left: x + 'px').addClass 'animate'
