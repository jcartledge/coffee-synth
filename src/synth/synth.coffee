class Synth

    constructor: (el) ->
        @modules = []
        @context = new webkitAudioContext()
        @view = new SynthView(el)
        @_dc = {}

    create: (type) ->
        return @context['create' + type[0].toUpperCase() + type[1..-1]]()

    add_module: (module) ->
        @modules.push(module)
        @render()

    render: ->
        @view.render(@modules)

    speaker: ->
        @context.destination

    connect: (src, target, input, options) ->
        amp = @create('gain')
        amp.gain.value = 1.0
        target.incoming(amp, input)
        src.outgoing(amp)
        # add a gain control to target if options supplied
        if options
            amp.gain.value = options.value
            target.add_range_control(
                'name': "#{src.name} &#x21dd; #{input}"
                'min': options.min
                'max': options.max
                'set': (n) => amp.gain.value = n
                'get': => amp.gain  .value
            )

    dc: (level) ->
        if not @_dc[level]
            size = 1024
            _dc = @context.createBufferSource()
            _dc.buffer = @context.createBuffer(1, size, @context.sampleRate)
            _dc_data = _dc.buffer.getChannelData(0)
            _dc_data[i] = level for i in [0...size]
            _dc.loop = true
            _dc.start(0)
            @_dc[level] = _dc
        @_dc[level]

    time: ->
        @context.currentTime

class SynthView

    constructor: (@el) ->

    render: (modules) ->
        @el.html('<div class="synth">')
        @el.append(module.render()) for module in modules

module.exports = Synth
