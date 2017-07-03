import QtQuick 2.8
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2

import "../components"
import "../services"

import space.qyvlik.blockchaininfo 1.0;


ScrollablePage {
    id: assetsPage

    title: "Settings"

    ColumnLayout {
        anchors.fill: parent

        Button {
            id: button
            property bool save2db: false
            text: "Start: " + save2db

            BlockChainInfo {
                id: blockChainInfo
                active: true
                subscribingAfterActive: true

                onTransaction: {
                    console.log("txid:", txObj.hash);
                    var inputs = txObj.inputs;
                    var out = txObj.out;
                    if (button.save2db) {

                        var dataList = [];

                        for(var iter0 in inputs) {
                            var input = inputs[iter0];
                            var inputAddr = input['prev_out']['addr'];
                            var inputAddrAmount = input['prev_out']['value'];

                            dataList.push({
                                              txHash: txObj.hash,
                                              address: inputAddr,
                                              receive: 0,
                                              amount: inputAddrAmount
                                          });
                        }

                        for(var iter1 in out) {
                            var output = out[iter1];
                            var outputAddr = output['addr'];
                            var outputAddrAmount = output['value'];
                            dataList.push({
                                              txHash: txObj.hash,
                                              address: outputAddr,
                                              receive: 1,
                                              amount: outputAddrAmount
                                          });
                        }

                        service.insertList(dataList, function(row){
                            console.log('insertList:', row);
                        });
                    }
                }
            }

            ListenTxHashService {
                id: service
                connection: databaseConfig
            }

            onClicked: {
                save2db = !save2db;
            }
        }
    }
}

