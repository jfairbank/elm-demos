import React, { PropTypes } from 'react';
import classNames from 'classnames';

const Icon = ({ name, size }) => (
  <i
    className={classNames(
      'fa',
      `fa-${name}`,
      { [`fa-${size}`]: size },
    )}
  />
);

Icon.propTypes = {
  name: PropTypes.string.isRequired,
  size: PropTypes.string.isRequired,
};

export default Icon;
