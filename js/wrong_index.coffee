
###
  $('.gu').click ->
    clearInterval timer
    $('#time').fadeOut 0
    $('#hand_right img').attr 'src', 'image/gu.png'
    #$("#hand_right img").attr 'src', '
    #$('#hand_left img').rdm 'src', 'image/gu.png', 'image/ch.png', 'image/pa.png'
    #rival = _.shuffle ['image/gu.png', 'image/ch.png', 'image/pa.png']
    #console.log _.shuffle [1, 2, 3, 4, 5]
    rival = _.shuffle(x)
    $('#hand_left img').attr 'src', rival[0]
    #if $('#hand_left img').attr('src') is 'image/gu.png'
    if $('#hand_left img').attr('src') is x[0] 
      $('.answer02').text('あいこ もう一回！')
    #else if $('#hand_left img').attr('src') is 'image/ch.png'
    else if $('#hand_left img').attr('src') is x[1] 
      $('.answer02').text('勝ち')
      $('#left_lifepoint').text('〇〇')

    else
      $('.answer02').text('負け')
      #console.log '負け'


  $('.ch').click ->
    $('#time').fadeOut 0
    clearInterval timer
    $('#hand_right img').attr 'src', 'image/ch.png'
    rival = _.shuffle(x)
    $('#hand_left img').attr 'src', rival[0]
    if $('#hand_left img').attr('src') is x[0]
      $('.answer02').text('負け')
    else if $('#hand_left img').attr('src') is x[1]
      $('.answer02').text('あいこ もう一回！')
    else
      $('.answer02').text('勝ち')


  $('.pa').click ->
    $('#time').fadeOut 0
    clearInterval timer
    $('#hand_right img').attr 'src', 'image/pa.png'
    rival = _.shuffle(x)
    $('#hand_left img').attr 'src', rival[0]
    if $('#hand_left img').attr('src') is x[0]
      $('.answer02').text('勝ち')
    else if $('#hand_left img').attr('src') is x[1]
      $('.answer02').text('負け')
    else
      $('.answer02').text 'あいこ もう一回！'
###

