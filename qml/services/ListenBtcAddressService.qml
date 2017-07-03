import space.qyvlik.sqml 1.0

import space.qyvlik.utils 1.0

CrudService {
    id: listenBtcAddressService
    __dao: ListenBtcAddressDao {
        __connection: listenBtcAddressService.connection
    }

    function saveBtcAddress(address, aliasName) {
        var Promise = PromiseLib.Promise;

        return new Promise(function(resolve, reject) {

            var addressEntity = {
                "address": address,
                "aliasName": aliasName,
                "balance": 0,
                "createTime": Date.now(),
                "listen": "1"
            };

            insert(addressEntity, function(rowsAffected){
                resolve(rowsAffected)
            }, function(error){
                reject(error);
            });
        });
    }
}
