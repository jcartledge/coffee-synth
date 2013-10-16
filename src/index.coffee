require('jquery-browserify')( ->

    synth = new (require('./synth/index.coffee').Synth)($('#synth'))
    modules = require('./synth/index.coffee').modules

    dco = new modules.DCO(synth, 'DCO', 'square')
    lfo = new modules.LFO(synth)
    dcf = new modules.DCF(synth)
    dca = new modules.DCA(synth)

    lfo.connect(dco, 'frequency',
        'value': 20
        'min': 0
        'max': 200
    )
    lfo.connect(dcf, 'frequency',
        'value': 100
        'min': 0
        'max': 200
    )
    lfo.connect(dca, 'gain',
        'value': .5
        'min': 0
        'max': 1
    )
    dco.connect(dcf)
    dcf.connect(dca)

    dca.connect(new modules.Speaker(synth))


    $('body').on('keydown', -> synth.trigger(220))
    $('body').on('keyup', -> synth.release(220))

)
