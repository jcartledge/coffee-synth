class Keyboard


    constructor: (@paper, octaves = 2, start_octave = 2) ->
        @mousedown = 0
        document.addEventListener('mousedown', => ++@mousedown)
        document.addEventListener('mouseup', => --@mousedown)

        @ww = (@paper.width / octaves) / 7
        @wh = @paper.height
        @bw = @ww * 0.6
        @bh = @wh * 0.6

        @x = -@ww

        @w_fill = '#EEE'
        @b_fill = '#000'
        @w_pressed_fill = '#DDD'
        @b_pressed_fill = '#666'

        @keys = {}
        @key_names = 'CC#DD#EFF#GG#AA#B'.match(/[A-Z]#?/g)
        key_num = 0

        for octave in [start_octave..octaves + start_octave - 1]
            for key_name in @key_names
                key_num++

                if key_name.match(/#/)
                    key = @draw_black_key(key_num)
                else
                    key = @draw_white_key(key_num)

                key.data('keyName', key_name + octave)
                    .mousedown(@key_on(key))
                    .mouseup(@key_off(key))
                    .mouseover(@key_over(key))
                    .mouseout(@key_out(key))

    draw_white_key: (key_num) ->
        @paper.rect(@x += @ww, 0, @ww, @wh, 3)
            .data('fill', @w_fill)
            .data('pressedFill', @w_pressed_fill)
            .attr('fill', @w_fill)
            .attr('stroke', '#999')
            .toBack();

    draw_black_key: (key_num) ->
        @paper.rect(@x + (@ww * 0.7), 0, @bw, @bh, 2)
            .data('fill', @b_fill)
            .data('pressedFill', @b_pressed_fill)
            .attr('fill', @b_fill)
            .attr('stroke', '#999')

    key_on: (key) ->
        -> console.log('on', key)

    key_off: (key) ->
        -> console.log('off', key)

    key_over: (key) ->
        => console.log('on', key) if @mousedown

    key_out: (key) ->
        => console.log('off', key) if @mousedown

module.exports = Keyboard
