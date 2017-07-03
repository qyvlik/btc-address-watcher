import space.qyvlik.sqml 1.0

CrudService {
    id: listenBtcAddressService
    __dao: ListenBtcAddressDao {
        __connection: listenBtcAddressService.connection
    }

    function saveBtcAddress(address, aliasName, callback) {
        callback = callback || function(rowsAffected) {
            console.info("saveBtcAddress : rowsAffected", rowsAffected);
        }

        var addressEntity = {
            "address": address,
            "aliasName": aliasName,
            "balance": 0,
            "createTime": Date.now(),
            "listen": "1"
        };
        insert(addressEntity, callback);
    }
}
