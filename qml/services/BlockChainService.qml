import QtQuick 2.0

import space.qyvlik.blockchaininfo 1.0;

import "../services"

Item {
    id: blockChainService

    property bool save2db: false
    property alias active: blockChainInfo.active

    BlockChainInfo {
        id: blockChainInfo
        subscribingAfterActive: blockChainInfo.active

        onTransaction: {
            if (!save2db) {
                return;
            }

            var inputs = txObj.inputs;
            var out = txObj.out;


            var dataList = [];

            for(var iter0 in inputs) {
                var input = inputs[iter0];
                var inputAddr = input['prev_out']['addr'];
                var inputAddrAmount = input['prev_out']['value'];

                if (inputAddr === '') {
                    continue;
                }

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

                if (outputAddr === '') {
                    continue;
                }

                dataList.push({
                                  txHash: txObj.hash,
                                  address: outputAddr,
                                  receive: 1,
                                  amount: outputAddrAmount
                              });
            }

            listenTxHashService.insertList(dataList, function(row){
                console.info('insertList txid:', txObj.hash, " row:", row);
            });
        }
    }

    ListenTxHashService {
        id: listenTxHashService
        connection: databaseConfig
    }
}
