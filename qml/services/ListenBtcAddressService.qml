import space.qyvlik.sqml 1.0

import space.qyvlik.utils 1.0

CrudService {
    id: listenBtcAddressService
    __dao: ListenBtcAddressDao {
        __connection: listenBtcAddressService.connection
    }

    function saveBtcAddress(address, aliasName) {
        var Promise = PromiseLib.Promise;


        var __insert = function(resolve, reject) {
            var addressEntity = {
                "address": address,
                "aliasName": aliasName,
                "balance": 0,
                "createTime": Date.now(),
                "listen": "1"
            };

            var r = new RegExp('^[13][a-km-zA-HJ-NP-Z1-9]{25,33}$');
            if (!r.test(address)) {
                reject('address ' + address + " not a btc address");
                return;
            }

            insert(addressEntity, function(rowsAffected){
                resolve(rowsAffected)
            }, function(error){
                reject(error);
            });
        };

        return btcAddressExist(address)
        .then(function(list){
            if (list.length !== 0) {
                console.error("btcAddressExist:", address);
                throw new Error('btcAddressExist ' + address);
            }
            return new Promise(__insert);
        });
    }

    function btcAddressExist(address) {
        var Promise = PromiseLib.Promise;

        return new Promise(function(resolve, reject) {
            listenBtcAddressService.findList({'address': address},
                                             function(list){
                resolve(list);
            }, function(e){
                reject(e);
            });
        });
    }

    function deleteAddress(address) {
        var Promise = PromiseLib.Promise;
        return new Promise(function(resolve, reject){
            deleteRecord({address:address}, resolve)
        });
    }
}
