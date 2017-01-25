import React from 'react';
import Elm from 'react-elm-components';
import { Main } from '01-counter/src/exports';

const CounterPage = () => (
  <div style={{ textAlign: 'center' }}>
    <h1>01 - Counter App</h1>

    <Elm src={Main} />
  </div>
);

export default CounterPage;
