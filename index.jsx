import React from 'react';
import { Sparklines, SparklinesBars } from 'react-sparklines';

export default class UDSparklines extends React.Component {
    render() {
      return (
        <Sparklines data={this.props.data} limit={10} >
            <SparklinesBars color={this.props.color} />
        </Sparklines>
      );
    }
}

