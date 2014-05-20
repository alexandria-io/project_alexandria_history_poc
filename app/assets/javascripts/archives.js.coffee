$(document).ready ->
  device_pixel_ratio = window.devicePixelRatio || (window.screen.availWidth / document.documentElement.clientWidth)
  canvas_element = $('#word_cloud')[0]
  $(canvas_element).attr 'width', canvas_element.offsetWidth * device_pixel_ratio
  $(canvas_element).attr 'height', canvas_element.offsetHeight * device_pixel_ratio
  foo =
    weightFactor: (size) ->
        Math.pow(size, 2.3) * $("#canvas").width() / 1024

    fontFamily: "Times, serif"

    rotateRatio: 0.5
    backgroundColor: "#ffe0e0"

  WordCloud canvas_element,
    list: $('#canvas_data').data('word-count'),
    gridSize: Math.round(16 * $("#canvas").width() / 1024)
    backgroundColor: '#5ec1f0',
    rotateRatio: .5,
    fontWeight: 200,
    color: (word, weight) ->
      num = _.random(0, 2)
      if num == 0
        '#fff'
      else if num == 1
        '#4C4C4A'
      else if num == 2
        '#404041'
