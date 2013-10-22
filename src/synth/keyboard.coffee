class Keyboard

    mousedown: 0
    subscribers: []

    constructor: (@paper, @octaves = 2, @start_octave = 2) ->
        @draw()

    draw: ->
        @paper.clear();
        w = (@paper.width / @octaves) / 7
        h = @paper.height

        draw_key = (x, key_num) =>
            is_black = key_num % 12 in [2,4,7,9,11]
            if is_black
                key = @paper.rect(x + (w * 0.7), 0, w * 0.6, h * 0.6, 2)
                    .attr('fill', '#111').attr('stroke', '#999')
                    .data('alt-fill', '#333')
            else
                key = @paper.rect(x += w, 0, w, h, 3)
                    .attr('fill', '#EEE').attr('stroke', '#999')
                    .data('alt-fill', '#DDD')
                    .toBack();

            key.data('f', 440 * Math.pow(2, ((key_num - 58)/12)))
                .mousedown( =>
                    @mousedown = true
                    @key_on(key)
                )
                .mouseup( =>
                    @mousedown = false
                    @key_off(key)
                )
                .mouseover( => @key_on(key) if @mousedown)
                .mouseout( => @key_off(key) if @mousedown)
            x

        keys = []
        keys.push(key + octave * 12) \
            for key in [1..12] \
            for octave in [@start_octave...@octaves + @start_octave]
        keys.reduce(draw_key, -w)

    key_on: (key) ->
        @swap_fill(key)
        subscriber.trigger(key.data('f')) for subscriber in @subscribers

    key_off: (key) ->
        @swap_fill(key)
        subscriber.release(key.data('f')) for subscriber in @subscribers

    swap_fill: (key) ->
        alt_fill = key.data('alt-fill')
        key.data('alt-fill', key.attr('fill'))
        key.attr('fill', alt_fill)

    connect: (subscriber) ->
        @subscribers.push(subscriber)

module.exports = Keyboard
