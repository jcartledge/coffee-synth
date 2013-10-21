require('jquery-browserify')( ->

    synth = new (require('./synth/index.coffee').Synth)($('#synth'))
    modules = require('./synth/index.coffee').modules

    paper = new (require('raphael-browserify'))('keyboard', 1000, 200)
    keyboard = new (require('./synth/keyboard.coffee'))(paper, 4, 1)
    console.log(keyboard)

    dco = new modules.DCO(synth)
    lfo = new modules.LFO(synth)
    dcf = new modules.DCF(synth)
    dca = new modules.DCA(synth)

    lfo.connect(dco, 'frequency',
        'min': 0
        'max': 200
    )
    lfo.connect(dcf, 'frequency',
        'min': 0
        'max': 200
    )
    lfo.connect(dca, 'gain',
        'value': 0
        'min': 0
        'max': 1
    )
    dco.connect(dcf)
    dcf.connect(dca)

    dca.connect(new modules.Speaker(synth))

    $('body').on('keydown', (e) -> dco.trigger(220))
    $('body').on('keyup', (e) -> dco.release(220))

)
