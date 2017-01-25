import React from 'react';
import ReactDOM from 'react-dom';

function render() {
  // eslint-disable-next-line global-require
  const App = require('components/App').default;

  ReactDOM.render((
    <App />
  ), document.getElementById('main'));
}

if (module.hot) {
  module.hot.accept('components/App', () => {
    render();
  });
}

render();
