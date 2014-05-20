$(document).ready ->
  devicePixelRatio = window.devicePixelRatio || (window.screen.availWidth / document.documentElement.clientWidth)
  canvasElement = $('#word_cloud')[0]
  canvasElement.setAttribute('width', canvasElement.offsetWidth * devicePixelRatio)
  canvasElement.setAttribute('height', canvasElement.offsetHeight * devicePixelRatio)
  foo =
    gridSize: Math.round(16 * $("#canvas").width() / 1024)
    weightFactor: (size) ->
        Math.pow(size, 2.3) * $("#canvas").width() / 1024

    fontFamily: "Times, serif"
    color: (word, weight) ->
      (if (weight is 12) then "#f02222" else "#c09292")

    rotateRatio: 0.5
    backgroundColor: "#ffe0e0"

  WordCloud canvasElement,
    list: $('#canvas_data').data('word-count'),
    backgroundColor: '#5ec1f0'
