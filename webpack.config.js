const path = require('path');
const webpack = require('webpack');
const ExtractTextPlugin = require('extract-text-webpack-plugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');

const production = process.env.NODE_ENV === 'production';

const config = {
  entry: path.resolve(__dirname, 'server/main.js'),

  output: {
    path: path.resolve(__dirname, 'public'),
    filename: 'main.js',
    publicPath: 'http://localhost:3000/',
  },

  resolve: {
    modules: [
      __dirname,
      path.resolve(__dirname, 'server'),
      'node_modules',
    ],
  },

  module: {
    rules: [
      {
        test: /\.html$/,
        exclude: /node_modules/,
        loader: 'file-loader?name=[name].[ext]',
      },

      {
        test: /\.js$/,
        exclude: /node_modules/,
        loader: 'babel-loader',
      },

      {
        test: /\.elm$/,
        exclude: /elm-stuff|node_modules/,
        loader: 'elm-webpack-loader',
      },
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    historyApiFallback: true,
  },

  plugins: [
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, 'server/index.ejs'),
    }),
  ],
};

if (production) {
  config.output.filename = 'main-[chunkhash].js';
  config.output.publicPath = '/';

  config.module.rules.push({
    test: /\.css$/,

    loader: ExtractTextPlugin.extract({
      fallbackLoader: 'style-loader',
      loader: 'css-loader',
    }),
  });

  config.plugins.push(
    new webpack.NoEmitOnErrorsPlugin(),

    new ExtractTextPlugin('main-[chunkhash].css'),

    new webpack.optimize.UglifyJsPlugin({
      minimize: true,
    }),

    new webpack.DefinePlugin({
      'process.env': { NODE_ENV: JSON.stringify('production') },
    }) // eslint-disable-line comma-dangle
  );
} else {
  config.module.rules.push({
    test: /\.css$/,
    use: ['style-loader', 'css-loader'],
  });
}

module.exports = config;
