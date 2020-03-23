import React from 'react';
import renderer from 'react-test-renderer';

import $COMPONENT_NAME$ from '$COMPONENT_PATH$';

describe('<$COMPONENT_NAME$ />', () => {
    it('should match the snapshot', () => {
      const component = renderer.create(<$COMPONENT_NAME$ />).toJSON();
      expect(component).toMatchSnapshot();
    });
  });