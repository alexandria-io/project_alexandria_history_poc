$(document).ready ->
  WordCloud ("my_canvas"),
    list: $('#canvas_data').data('word-count'),
    gridSize: Math.round(16 * $("#canvas").width() / 1024)

    fontFamily: "Times, serif"

    rotateRatio: 0.5
