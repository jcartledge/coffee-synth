require('jquery-browserify')( ->

    synth = new (require('./synth/index.coffee').Synth)($('#synth'))
    modules = require('./synth/index.coffee').modules

    paper = new (require('raphael-browserify'))('keyboard', 1000, 200)
    keyboard = new modules.Keyboard(paper, 4, 2)

    dco = new modules.DCO(synth)
    lfo = new modules.LFO(synth)
    dcf = new modules.DCF(synth)
    adsr = new modules.ADSR(synth)
    dca = new modules.DCA(synth)

    lfo.connect(dco, 'frequency',
        'min': 0
        'max': 200
    )
    adsr.connect(dco, 'frequency',
        'value': 0
        'min': 0
        'max': 200
    )

    dco.connect(dcf)

    lfo.connect(dcf, 'frequency',
        'min': 0
        'max': 200
    )
    adsr.connect(dcf, 'frequency',
        'min': 0
        'max': 1000
    )

    dcf.connect(dca)

    lfo.connect(dca, 'gain',
        'value': 0
        'min': 0
        'max': 1
    )
    adsr.connect(dca, 'gain',
        'value': 0
        'min': 0
        'max': 1
    )

    adsr.connect_trigger(dco)
    keyboard.connect_trigger(adsr)

    dca.connect(new modules.Speaker(synth))


)
