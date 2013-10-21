$ = require('jquery-browserify')

class Keyboard

    mousedown: 0

    constructor: (@paper, @octaves = 2, @start_octave = 2) ->
        $('body').on('mousedown', =>
            @mousedown = true
        ).on('mouseup', =>
            @mousedown = false
        )
        @draw()

    draw: ->
        w = (@paper.width / @octaves) / 7
        h = @paper.height

        draw_key = (x, key_num) =>
            is_black = key_num % 12 in [2,4,7,9,11]
            if is_black
                key = @paper.rect(x + (w * 0.7), 0, w * 0.6, h * 0.6, 2)
                    .attr('fill', '#111').attr('stroke', '#999')
            else
                key = @paper.rect(x += w, 0, w, h, 3)
                    .attr('fill', '#EEE').attr('stroke', '#999')
                    .toBack();

            key.data('f', 440 * Math.pow(2, ((key_num - 58)/12)))
                .mousedown(@key_on(key))
                .mouseup(@key_off(key))
                .mouseover( => @key_on(key)() if @mousedown)
                .mouseout( => @key_off(key)() if @mousedown)
            x

        keys = []
        keys.push(key + octave * 12) \
            for key in [1..12] \
            for octave in [@start_octave...@octaves + @start_octave]
        keys.reduce(draw_key, -w)

    key_on: (key) ->
        -> console.log('on', key.data('f'))

    key_off: (key) ->
        -> console.log('off', key.data('f'))

module.exports = Keyboard
