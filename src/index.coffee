require('jquery-browserify')( ->

    synth = new (require('./synth/index.coffee').Synth)($('#synth'))
    modules = require('./synth/index.coffee').modules

    vco = new modules.VCO(synth, 'VCO', 'square')
    lfo = new modules.LFO(synth)
    vcf = new modules.VCF(synth)
    vca = new modules.VCA(synth)

    lfo.connect(vco, 'frequency', 20)
    lfo.connect(vcf, 'frequency', 100)
    lfo.connect(vca, 'gain', .5)
    vco.connect(vcf)
    vcf.connect(vca)

    vca.connect(new modules.Speaker(synth))

    synth.start(220)

)
