require('jquery-browserify')( ->

    synth = new (require('./synth/index.coffee').Synth)($('#synth'))
    modules = require('./synth/index.coffee').modules

    vco = new modules.VCO(synth, 'VCO', 'square')
    lfo = new modules.LFO(synth)
    vcf = new modules.VCF(synth)
    vca = new modules.VCA(synth)

    lfo.connect(vco, 'frequency',
        'value': 20
        'min': 0
        'max': 200
    )
    lfo.connect(vcf, 'frequency',
        'value': 100
        'min': 0
        'max': 200
    )
    lfo.connect(vca, 'gain',
        'value': .5
        'min': 0
        'max': 1
    )
    vco.connect(vcf)
    vcf.connect(vca)

    vca.connect(new modules.Speaker(synth))

    synth.start(220)

)
