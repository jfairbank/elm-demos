const path = require('path');

module.exports = {
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
        test: /\.css$/,
        use: ['style-loader', 'css-loader'],
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
    // contentBase: false,
    historyApiFallback: true,
    // hot: true,
    // inline: true,
    // port: 3000,
  },
};
