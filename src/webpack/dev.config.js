var path = require('path');
var webpack = require('webpack');


module.exports =
{ entry: path.resolve(__dirname, '..')
, output:
  { path: path.resolve(__dirname, '..', '..')
  , filename: 'bundle.js'
  }
, devtool: '#cheap-module-eval-source-map'
, plugins:
  [ new webpack.DefinePlugin(
      { 'process.env':
        { NODE_ENV: JSON.stringify('production')
      }
    })
  , new webpack.optimize.DedupePlugin()
  , new webpack.optimize.UglifyJsPlugin(
      { compress: { warnings: false }
      })
  ]
, module:
  { loaders:
    [ { test: /\.js$/
      , loaders: ['babel']
      , exclude: /node_modules/
      , include: path.resolve(__dirname, '..')
      }
    , { test: /\.json$/, loader: "json-loader?paths=/src/js/"
      }
    ]
  }
};

