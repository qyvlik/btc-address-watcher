import space.qyvlik.sqml 1.0

CrudService {
    id: listenTxHashService
    __dao: ListenTxHashDao {
        __connection: listenTxHashService.connection
    }
}
