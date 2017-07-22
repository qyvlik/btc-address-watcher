import space.qyvlik.sqml 1.0

CrudDao {
    id: listenBtcAddressDao
    __sqlMapping: ListenTxHashSqlMapping {
        id: sqlMapping
    }

    function deleteAll(callback, error) {
        __executeSqlImpl({}, sqlMapping.deleteAll, false, function(results){
            callback(results.rowsAffected);
        }, error);
    }
}
