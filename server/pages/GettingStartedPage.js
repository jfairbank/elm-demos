import React from 'react';
import Elm from 'react-elm-components';
import { Main } from '01-getting-started/src/exports';

const GettingStartedPage = () => (
  <div style={{ textAlign: 'center' }}>
    <h1>01 - Getting Started</h1>
    <h2>Counter Demo</h2>

    <Elm src={Main} />
  </div>
);

export default GettingStartedPage;
