# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("section[data-type=\"background\"]").each ->
    $bgobj = $(this) # assigning the object
    $(window).scroll ->
      yPos = -($window.scrollTop() / $bgobj.data("speed"))
      
      # Put together our final background position
      coords = "50% " + yPos + "px"
      
      # Move the background
      $bgobj.css backgroundPosition: coords
      return

    return

  return