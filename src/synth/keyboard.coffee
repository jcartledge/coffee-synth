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
        i = 0

        end_octave = octaves + (start_octave - 1)
        for octave in [start_octave..end_octave]
            for key_name in @key_names
                i++
                key_num = (start_octave * 12) + i

                if key_name.match(/#/)
                    key = @draw_black_key(i)
                else
                    key = @draw_white_key(i)

                key.data('key_name', key_name + octave)
                    .data('key_num', key_num)
                    .data('f', @f(key_num))
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

    f: (key_num) ->
        440 * Math.pow(2, ((key_num - 58)/12))

    key_on: (key) ->
        -> console.log('on', key.data('f'))

    key_off: (key) ->
        -> console.log('off', key.data('f'))

    key_over: (key) ->
        => console.log('on', key.data('f')) if @mousedown

    key_out: (key) ->
        => console.log('off', key.data('f')) if @mousedown

module.exports = Keyboard
