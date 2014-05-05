$(document).ready ->
  WordCloud ("my_canvas"),
    list: $('#canvas_data').data('word-count')
