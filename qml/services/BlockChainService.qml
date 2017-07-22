import QtQuick 2.0

import space.qyvlik.blockchaininfo 1.0

import space.qyvlik.utils 1.0

Item {
    id: blockChainService

    property bool save2db: false
    property alias active: blockChainInfo.active

    Lazyer {
        id: lazyer
    }

    Ticker {
        id: ticker
    }

    BlockChainInfo {
        id: blockChainInfo
        subscribingAfterActive: blockChainInfo.active

        onError: {
            console.error("blockChainInfo error:", errorString);
            blockChainInfo.active = false;
            ticker.tick(5000, function(){
                console.info("tick : try to reopen websocke")
                if (blockChainInfo.isOpen) {
                    ticker.stop()
                }
                blockChainInfo.active = true;
            })
        }

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

                if (!Utility.stringNotEmpty(inputAddr)) {
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

                if (!Utility.stringNotEmpty(outputAddr)) {
                    continue;
                }

                dataList.push({
                                  txHash: txObj.hash,
                                  address: outputAddr,
                                  receive: 1,
                                  amount: outputAddrAmount
                              });
            }

            if (dataList.length === 0) {
                return;
            }

            Utility.listGroup(dataList, 200, function(list){
                listenTxHashService.insertList(list, function(row){
                    console.info('insertList txid:', txObj.hash, " row:", row);
                });
            });
        }
    }

    ListenTxHashService {
        id: listenTxHashService
        connection: databaseConfig
    }

    function deleteAllTx() {
        return listenTxHashService.deleteAll();
    }
}
