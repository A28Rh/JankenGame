$ ->

  app.setBind()
  app.initialize()

app =

  all_hand: ['image/gu.png', 'image/ch.png', 'image/pa.png']
  time: 3
  timer: null
  heart_image:
    'red': 'image/heart_red.png'
    'black': 'image/heart_black.png'
  lifepoint:
    'my': 3
    'rival': 3

  #下の2つどちらでも可能
  #lifepoint['my']
  #lifepoint.my

  #配列を呼び出し
  #animal = ['inu', 'neko', 'tori']
  #animal[0]

  #連想配列、ハッシュ、#
  #animal =
  #  0: 'inu'
  #  1: 'neko'
  #  2: 'tori'

  #連想配列、ハッシュ、#
  #animal =
  #  'inu' : 'shiba'
  #  'neko': 'mike'
  #  'tori': 'inko'

  #連想配列呼び出し方法、下記2つどちらでも可能
  #animal['inu']
  #animal.inu

  initialize: ->
    console.log 'init'
    console.log @heart_image.red

  setBind: ->
    $('.gu').click =>
      @janken 0
      @clearTimeAnimation()

    $('.ch').click =>
      @janken 1
      @clearTimeAnimation()

    $('.pa').click =>
      @janken 2
      @clearTimeAnimation()

    $('.start').click =>
      @start()

    $('.reset').click =>
      @reset()

  clearTimeAnimation: ->
    @clearTimer true
    @cannotClickHand true
    @controlClickStart()

  controlClickStart: ->
    if 1<=@lifepoint.my<=3 and 1<=@lifepoint.rival<=3
      @cannotClickStart false
    else if @lifepoint.my or @lifepoint.rival is 0
      @cannotClickStart true

  start: ->
    @cannotClickStart true
    @clearBothHand()
    $('#time').css 'display', 'block'
    $('.nokoritime').css 'display', 'block'
    $('.answer03').css 'display', 'none'
    $('.answer').css 'display', 'none'
    $('.answer01').fadeIn 500, ->
      $('.answer01').fadeOut 500, ->
        $('.answer02').fadeIn 1000, ->
          $('.time').text app.time
          $('.nokoritime').css 'display', 'none'
          $('.time').css 'display', 'block'
          app.cannotClickHand false
          app.startTimer()

  reset: ->
    $('.answer02').css 'display', 'none'
    $('.answer03').css 'display', 'none'
    $('.answer').css 'display', 'table-cell'
    @clearBothHand()
    @cannotClickHand true
    @cannotClickStart false
    @clearTimer false
    @changeHeartRedImage()
    @lifepoint.my = 3
    @lifepoint.rival = 3

  clearBothHand: ->
    $('#my_hand img').attr 'src', 'image/gu.png'
    $('#rival_hand img').attr 'src', 'image/gu.png'

  janken: (hand) ->
    rival = @getRivalHand()
    @changeMyHandImage hand
    @changeRivalHandImage rival
    @judgeJanken hand, rival

  getRivalHand: ->
    rival = _.random 0, 2

  changeMyHandImage: (hand) ->
    $('#my_hand img').attr 'src', @all_hand[hand]

  changeRivalHandImage: (rival) ->
    $('#rival_hand img').attr 'src', @all_hand[rival]

  judgeJanken: (hand, rival) ->
    if hand is rival
      $('.answer03').text 'あいこ もう一回'
      @poonToResult()
    else if (hand + 1 is rival) or (hand is 2 and rival is 0)
      $('.answer03').text '勝ち'
      @poonToResult()
      @decrementLifepoint 'rival'
    else
      $('.answer03').text '負け'
      @poonToResult()
      @decrementLifepoint 'my'

  poonToResult: ->
    $('.answer02').css 'display', 'none'
    $('.answer03').css 'display', 'table-cell'

  decrementLifepoint: (my_or_rival) -> # 'my' or 'rival'
    @lifepoint[my_or_rival]--
    if @lifepoint[my_or_rival] is 2
      $(".#{my_or_rival}_lifepoint03 img").attr 'src', @heart_image.black
    else if @lifepoint[my_or_rival] is 1
      $(".#{my_or_rival}_lifepoint02 img").attr 'src', @heart_image.black
    else if @lifepoint.rival is 0
      @winJanken()
    else if @lifepoint.my is 0
      @loseJanken()

  loseJanken: ->
    $('.my_lifepoint01 img').attr 'src', @heart_image.black
    @setModal 'lose'
    @closeModal 'lose'
    @cannotClickStart true

  winJanken: ->
    $('.rival_lifepoint01 img').attr 'src', @heart_image.black
    @setModal 'win'
    @closeModal 'win'
    @cannotClickStart true

  changeHeartRedImage: ->
    $('.rival_lifepoint03 img').attr 'src', @heart_image.red
    $('.rival_lifepoint02 img').attr 'src', @heart_image.red
    $('.rival_lifepoint01 img').attr 'src', @heart_image.red
    $('.my_lifepoint01 img').attr 'src', @heart_image.red
    $('.my_lifepoint02 img').attr 'src', @heart_image.red
    $('.my_lifepoint03 img').attr 'src', @heart_image.red

  cannotClickHand: (is_cannot_click) ->
    $('.gu').attr 'disabled', is_cannot_click
    $('.ch').attr 'disabled', is_cannot_click
    $('.pa').attr 'disabled', is_cannot_click

  cannotClickStart: (is_cannot_click) ->
    $('.start').attr 'disabled', is_cannot_click

  startTimer: ->
    @timer = setInterval =>
      @time--
      @changeTimeBackgroundColor()
      $('.time').text @time
      if @time is 0
        alert '時間切れ HP-1'
        @clearTimer false
        @cannotClickStart false
        @cannotClickHand true
        $('.answer02').css 'display', 'none'
        $('.answer').css 'display', 'table-cell'
        @decrementLifepoint 'my'
    , 1000

  changeTimeBackgroundColor: ->
    if @time is 3
      $('#time').css 'background-color', '#FFFFCC'
    else if @time is 2
      $('#time').css 'background-color', '#FF9966'
    else if @time is 1
      $('#time').css 'background-color', '#FF3300'

  clearTimer: (is_time_none) ->
    clearInterval @timer
    @time = 3
    @changeTimeBackgroundColor()
    $('.time').css 'display', 'none'
    if is_time_none
      $('#time').css 'display', 'none'
    else
      $('#time').css 'display', 'block'
      $('.nokoritime').css 'display', 'block'

  resetTimeBackgroundColor: ->
    $('#time').css 'background-color', '#FFFFCC'

  setModal: (win_or_lose) ->
    $("#modal-#{win_or_lose}").fadeIn 1000
    $('#modal-overlay').fadeIn 1000

  closeModal: (win_or_lose) ->
    $('#modal-overlay').click ->
      $("#modal-#{win_or_lose}").fadeOut 1000
      $('#modal-overlay').fadeOut 1000
    $("#modal-#{win_or_lose}-close").click ->
      $("#modal-#{win_or_lose}").fadeOut 1000
      $('#modal-overlay').fadeOut 1000

