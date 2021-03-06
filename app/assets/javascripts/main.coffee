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

validate_filters = ->
#  $('.one-sel-filter').hide()
  success = true
#  $('.filters-wrap input').each ->
#    if $(@).val() == ''
#      filter_block = $(@).closest('.filter-block')
#      filter_class = filter_block.attr ' data-filter-class'
#      $("'."+filter_class+"'").show()
#      jQuery(this).next().show()
#      success = false
#  success
$(document).ready ->


  $('.apartment-key-for-search a').click (event)->
    event.preventDefault()

    $this = $(@)
    searching_query = $this.attr 'data-search-query'
    $input = $this.closest('.apartment-form-wrap').find('input[name=search]')

    $input.val(searching_query)

  $(document).on 'click', '.one-sel-filter a', (event)->
    filter_link = $(@).closest('.one-sel-filter')
    filter_anchor = filter_link.attr 'data-filter-anchor'
    current_selector = $("."+filter_anchor)
    if current_selector.find('input')
      filter_inputs = current_selector.find('input')
      filter_inputs.each ->
        this_input = $(@)
        if $(@).is(":checked")
          this_input.trigger('click')
        filter_link.hide()
    if current_selector.find('select').length > 0
      $select_link = current_selector.find('select')
      first_option = $select_link.find('option').first().attr 'value'
      $select_link.val(first_option)
      $select_link.trigger('change')
      filter_link.hide()

#  $(document).on 'change', '.filter-block-auto-update input#turn-notification', (event)->
#    wrap = $(@).closest('.catalog-filters-form')
#    if $(@).is(':checked')
#      wrap.attr('id', 'filterrific_filter')
#      $(document).trigger('ready')
#    else
#      wrap.attr('id', 'filterrific-no-ajax-auto-submit')
#      $(document).trigger('ready')
#
  $('.filters-wrap').on 'change', '.filter-block input, .filter-block select', (event)->
    filter_block = $(@).closest('.filter-block')
    filter_class = filter_block.attr 'data-filter-class'
#    console.log('selector',$("."+filter_class))
    $("."+filter_class).show()
    $('.selected-filters-wrap').show()

#
  if(window.location.href.indexOf("apartment/catalog") > -1)
    console.log('apartment/catalog')
    validate_filters()

    selected_filters = $('.selected-filters-wrap')
    selected_filter = $('.one-sel-filter')

    filters_wrap = $('.filters-wrap')
    filter_block = $('.filter-block')

    if (window.location.href.indexOf("with_count_rooms") > -1) || (window.location.href.indexOf("with_city") > -1) || (window.location.href.indexOf("with_district") > -1) || (window.location.href.indexOf("with_price_from") > -1) || (window.location.href.indexOf("with_total_square_from") > -1) || (window.location.href.indexOf("with_level") > -1) || (window.location.href.indexOf("with_building_complex_name") > -1)
      $('.selected-filters-wrap').show()

    if (window.location.href.indexOf("with_count_rooms") > -1)
      $('.osf-count-rooms').show()
    if (window.location.href.indexOf("with_city") > -1)
      $('.osf-city').show()
    if (window.location.href.indexOf("with_district") > -1)
      $('.osf-district').show()
    if (window.location.href.indexOf("with_price_from") > -1)
      $('.osf-price').show()
    if (window.location.href.indexOf("with_total_square_from") > -1)
      $('.osf-live-square').show()
    if (window.location.href.indexOf("with_level") > -1)
      $('.osf-level').show()
    if (window.location.href.indexOf("with_building_complex_name") > -1)
      $('.osf-building-complex').show()


#
  $(document).on 'click', '.se-action-handler', (event)->
    event.preventDefault()

    $this = $(@)
    $item = $(@).closest('.se-action-handler-wrap')
    item_id = $item.attr 'data-item-id'

    if $(@).hasClass('add-to-favorites')
#      if $this.hasClass('aiht-action')
#        $item = $this.closest('.apartment-item-head-title-actions')
#        item_id = $item.attr 'data-item-id'

      if $item.hasClass('added-to-favorites')
        postData = {id: item_id}
        formURL = '/remove_apartment_from_favorites'
        form = this

        $.ajax
          url: formURL
          dataType: 'html'
          type: "POST"
          data: postData
          beforeSend: ->
            console.log('перед додаванням')
          success: ->
            $item.removeClass('added-to-favorites')
            if $this.closest('.best-apartment').hasClass('is-cabinet-list')
              is_cabinet_list = $this.closest('.best-apartment')
              $this.closest('.a-one-item').parent().remove()
          complete: ->
      else
        postData = {id: item_id}
        formURL = '/add_apartment_to_favorites'
        form = this

        $.ajax
          url: formURL
          dataType: 'html'
          type: "POST"
          data: postData
          beforeSend: ->
            console.log('перед додаванням')
          success: ->
            $item.addClass('added-to-favorites')
          complete: ->


    if $(@).hasClass('add-to-comparison')
      if $item.hasClass('added-to-comparison')
#        alert 'has'
        postData = {id: item_id}
        formURL = '/remove_apartment_from_comparison'
        form = this

        $.ajax
          url: formURL
          dataType: 'html'
          type: "POST"
          data: postData
          beforeSend: ->
#            alert 'before remove'
          success: ->
#            alert 'success'
            $item.removeClass('added-to-comparison')
            if $item.hasClass('comparison-one-item')
              $this.closest('.comparison-one-item').parent().remove()
          complete: ->
      else
        $.ajax
          type: 'GET'
          url: '/get_length_items_from_comparison'
          dataType: 'json'
          success: (data) ->
            if data < 3
              postData = {id: item_id}
              formURL = '/add_apartment_to_comparison'
              form = this

              $.ajax
                url: formURL
                dataType: 'html'
                type: "POST"
                data: postData
                beforeSend: ->
        #          console.log('перед додаванням')
        #          alert 'before writing to cookies'
                success: ->
        #          alert 'writed to cookies'
                  $item.addClass('added-to-comparison')
                complete: ->
            else
              $('#ErrorCountComparisonModal').foundation 'reveal', 'open'
#              alert 'sorry'

  #callback handler for form submit
  $('form.se-ajax-popup-form').submit (e) ->
    $this = $(@)
    postData = $this.serializeArray()
    formURL = $this.attr('action')
    form = this

    $.ajax
      url: formURL
      dataType: 'html'
      type: "POST"
      data: postData
      beforeSend: ->
        console.log('перед відсиланням')
      success: ->
        form.reset()
        $this.closest('form').find('.animate-input').each ->
          if !$(@).hasClass('is-locked-for-clear')
            $(@).removeClass('is-completed')
#
        $('#SuccessModal').foundation 'reveal', 'open'
      complete: ->

      error: ->

    e.preventDefault()

#  $('#book-review-modal').foundation 'reveal', 'open'

  $(document).on 'click', 'a[data-reveal-id]', ->
    console.log 'click!'
    hiden_apartment = $(@).attr 'data-apartment-id'
    console.log 'data', hiden_apartment

    this_form = $('#book-review-modal').find('form')
    this_form.find('input.apartment-id').val(hiden_apartment)

#    $(this).after '<br><a href=\'#\' data-reveal-id=\'revealAjaxModal\'>click me too!</a>'

  $( "#datepicker" ).datepicker()

#  $('form.ajax-form').submit (e) ->
#    e.preventDefault()
#    alert 'test1'

#  $('form.ajax-form').submit (e) ->
#    alert 'test'
#    postData = $(this).serializeArray()
#    formURL = $(this).attr('action')
#    $.ajax
#      url: formURL
#      type: 'POST'
#      data: postData
#      beforeSend: ->
#        console.log("before send")
#      success: (data, textStatus, jqXHR) ->
#  #data: return data from server
#        console.log("success send")
#      error: (jqXHR, textStatus, errorThrown) ->
#  #if fails
#
#    e.preventDefault()
    #STOP default action
#    e.unbind()
    #unbind. to stop multiple form submit.
#    return
#  $('.ajax-form').submit()
  #Submit  the FORM


#  $(document).on "submit", "form#call-order", (e) ->
#    e.preventDefault()
#    $.post @action, $(@).serializeArray()
#
#    $.ajax
#      url: '/get_cities_from_category'
#      type: "GET"
##      dataType: "json"
#      data: valuesToSubmit
#      beforeSend: ->
#        alert 'start send'
#      success: (data) ->
#        alert 'success'
#      complete: ->
#        alert 'complete'
##
#  $('form.ajax-form').submit (e) ->
#    e.preventDefault()
#    $.post @action, $(@).serializeArray()
#
#    $(@)[0].reset()
#    $(@).closest('form').find('.animate-input').each ->
#      $(@).removeClass('is-completed')
#
#    $('#SuccessModal').foundation 'reveal', 'open'

  # nav
  if(window.location.href.indexOf("apartment") > -1)
    $('.nav-catalogs .li-apartment').addClass('current')
  if(window.location.href.indexOf("complex") > -1)
    $('.nav-catalogs .li-complex').addClass('current')


  $('#sidebar').stickySidebar
    sidebarTopMargin: 20
    footerThreshold: 100

  $("#aniimated-thumbnials").lightGallery
    mode: 'lg-fade'
    thumbnail: true
#    exThumbImage: 'data-exthumbimage'

  $('#carousel').flexslider
    animation: 'slide'
    controlNav: false
    animationLoop: false
    slideshow: false
    itemWidth: 79
    itemMargin: 5
    asNavFor: '#slider'
  $('#slider').flexslider
    animation: 'slide'
    controlNav: false
    animationLoop: false
    slideshow: false
    sync: '#carousel'

# apartment gallery carousel
#    $('#a-carousel').flexslider
#    animation: 'slide'
#    controlNav: false
#    animationLoop: false
#    slideshow: false
#    itemWidth: 79
#    itemMargin: 5
#    asNavFor: '#slider'
#  $('#a-slider').flexslider
#    animation: 'slide'
#    controlNav: false
#    animationLoop: false
#    slideshow: false
#    sync: '#a-carousel'

  $('.a-nav-search-button a').click (e)->
    e.preventDefault()
    wrap = $(@).closest('.h-filter-list')

    if wrap.hasClass('header-search-form-opened')
      wrap.removeClass('header-search-form-opened')
    else
      wrap.addClass('header-search-form-opened')

  $('.mobile-menu-link').click ->
    $this = $(@)
    wrap = $this.closest('body')

    if !$this.hasClass('mm-opened')
      wrap.addClass('mm-opened')
      $this.addClass('mm-opened')
    else
      wrap.removeClass('mm-opened')
      $this.removeClass('mm-opened')
  $('a.mobile-menu-close').click ->
    $this = $(@)
    wrap = $this.closest('body')
    wrap.removeClass('mm-opened')
    $this.removeClass('mm-opened')

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

      console.log('min val',$this_min.attr 'val')
      console.log('max val',$this_max)

      range_price = $this.find(".range-slide")
      min_val = +range_price.attr('data-min-val')
      max_val = +range_price.attr('data-max-val')

      console.log('min 2 val',min_val)
      console.log('max 2 val',max_val)

      range_price.slider

        range: true
        min: min_val
        max: max_val
        values: [
          min_val
          max_val
        ]
#        change for filter catalog page
        change: ->
          if $(@).closest('.se-range-input').hasClass('filter-block')
            filter_block = $(@).closest('.filter-block')
            filter_class = filter_block.attr 'data-filter-class'
            $("."+filter_class).show()
            if $('.selected-filters-wrap').is(':hidden')
              $('.selected-filters-wrap').show()
#              alert 'hidden'
#            end fliter catalog page code
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
  $(".apartment-item-page ul.image-carousel").bxSlider
    auto: true,
    pause: 5000

#  apartment main banner
  $(".apartment-page-wrap .main-banner-wrap ul").bxSlider
    auto: true,
    pause: 5000


  $(".best-apartment ul.ba-carousel").bxSlider()


  $(".similar-apartments ul.similar-apartments-carousel").bxSlider()

#  complex
  $(".complex-page-wrap .main-banner-wrap ul").bxSlider
    auto: true,
    pause: 5000
  $(".complex-item-page ul.image-carousel").bxSlider
    auto: true,
    pause: 5000
  $(".best-complex ul.bc-carousel").bxSlider()
  $(".se-about-page ul.image-carousel").bxSlider()

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

  $('.my-accordion-navigation a').click (e) ->
    $parent =  $(@).closest('li')
    $content = $parent.find('.my-accordion-content')
    if $parent.hasClass('active')
      $parent.removeClass('active')
    else
      $parent.addClass('active')
    if $content.hasClass('active')
      $content.removeClass('active')
    else
      $content.addClass('active')
    e.preventDefault()

  gallery = null
  $('#complex-photo-gallery ul#lightgallery li').click ->
    $wrap =$(@).closest('#complex-photo-gallery')
    slides = $wrap.find('.for-lightGallery')

    cii = $(@).index()
    elmenetsListData = $.map($wrap.find('.for-lightGallery'), (el) ->
      {
      src: $(el).attr 'data-gallery-src'
      thumb: $(el).attr 'data-gallery-thumb'
      }
    )
    console.log("cii", cii)
    $gallery = $('#lightgallery')
    $gallery.lightGallery
      dynamic: true
      dynamicEl: elmenetsListData
      index: cii

    gallery ?= $gallery.data("lightGallery")
    gallery.index = cii
    console.log("gallery", gallery)
    window.gallery = gallery

  gallery = null

#  apartment light gallery
  $('#apartment-photo-gallery ul#lightgallery li').click ->
    $wrap =$(@).closest('#apartment-photo-gallery')
    slides = $wrap.find('.for-lightGallery')

    cii = $(@).index()
    elmenetsListData = $.map($wrap.find('.for-lightGallery'), (el) ->
      {
      src: $(el).attr 'data-gallery-src'
      thumb: $(el).attr 'data-gallery-thumb'
      }
    )
    console.log("cii", cii)
    $gallery = $('#lightgallery')
    $gallery.lightGallery
      dynamic: true
      dynamicEl: elmenetsListData
      index: cii

    gallery ?= $gallery.data("lightGallery")
    gallery.index = cii
    console.log("gallery", gallery)
    window.gallery = gallery
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


#$(window).scroll (event) ->
#  st = $(@).scrollTop()
#  ot = $('.c-info-nav-wrap').offset().top
#
#  if st >= ot
#    $('.c-info-nav-wrap').addClass('c-fixed-sidebar')
#    console.log('+')
#  else if st <= ot
#    console.log('-')
#    $('.c-info-nav-wrap').removeClass('c-fixed-sidebar')
#
