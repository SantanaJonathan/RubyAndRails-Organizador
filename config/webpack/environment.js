const { environment } = require('@rails/webpacker')

//todo esto para que la gem cocoon sea exitosa
const webpack = require('webpack')

environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
        $: 'jquery',
        jQuery: 'jquery',
        'window.jQuery': 'jquery',
        Popper: ['popper.js', 'default']
    })
)


module.exports = environment
