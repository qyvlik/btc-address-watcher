import space.qyvlik.sqml 1.0

import space.qyvlik.utils 1.0


CrudService {
    id: listenTxHashService
    __dao: ListenTxHashDao {
        id: dao
        __connection: listenTxHashService.connection
    }

    function deleteAll() {
        var Promise = PromiseLib.Promise;

        return new Promise(function(resolve, reject){
            dao.deleteAll(resolve, reject);
        });
    }
}
