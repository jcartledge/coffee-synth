require('jquery-browserify')( ->

    synth = new (require('./synth/index.coffee').Synth)($('#synth'))
    modules = require('./synth/index.coffee').modules

    vco = new modules.VCO(synth, 'VCO', 'square')
    lfo = new modules.LFO(synth)
    vcf = new modules.VCF(synth)
    vca = new modules.VCA(synth)

    lfo.connect(vco.input('frequency'), 20)
    lfo.connect(vcf.input('frequency'), 100)
    lfo.connect(vca.input('gain'), .5)
    vco.connect(vcf.input())
    vcf.connect(vca.input())

    vca.connect(synth.speaker())

    synth.start(220)

)
