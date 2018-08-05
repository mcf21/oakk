import "./shim.js";
import React, { Component } from "react";
import { View, Text, Button, TextInput, Picker } from "react-native";
import eosjs2 from "eosjs2";

const rpc = new eosjs2.Rpc.JsonRpc("http://172.16.96.204:8888");
const signatureProvider = new eosjs2.SignatureProvider([
  "5Kbka6hvgZtTWKB8BT6un2hQNFJsPz8A6n8HsUvSLAti6RDxFda"
]);
const api = new eosjs2.Api({ rpc, signatureProvider });

export default class App extends Component {
  state = {
    accountName: "john",
    treetype: 1,
    trackerId: this.props.trackerId || "NoTrackerId",
    txComplete: false,
    txHash: '',
    txString: ''
  };

  createTreeTx = async () => {
    try {
      console.log("sending...");
      this.setState({ isLoading: true })
      const result = await api.pushTransaction({
        blocksBehind: 2,
        expireSeconds: 30,
        actions: [
          {
            account: "trees",
            name: "plant",
            authorization: [
              {
                actor: this.state.accountName,
                permission: "active"
              }
            ],
            data: {
              planter: this.state.accountName,
              trackerid: this.state.trackerId,
              treetype: this.state.treetype
            }
          }
        ]
      });
      console.log(result);
      this.setState({ isLoading: false, txComplete: true, txString: JSON.stringify(result) })
    } catch (e) {
      console.log(e);
    }
  };

  render() {

    if (this.state.txComplete) return (
      <View>
        <Text>TX now complete</Text>
        <Text>{this.state.txString}</Text>
        <Button title="Dismiss" onPress={() => this.setState({ txComplete: false, txHash: '', txString: '' })} />
      </View>
    )

    return (
      <View>
        <Text>Account Name: {this.state.accountName}</Text>
        <Text>{this.props.nfcId || "NFC ID Not Passed"}</Text>
        <Picker
          selectedValue={this.state.treetype}
          style={{ height: 50, width: 59 }}
          onValueChange={(itemValue, itemIndex) =>
            this.setState({ treetype: itemValue })}
        >
          <Picker.Item label="Oak" value={1} />
          <Picker.Item label="Maple" value={2} />
        </Picker>
        <Button title={this.state.isLoading ? "Loading...": "Plant Tree"} onPress={this.createTreeTx} />
      </View>
    );
  }
}
