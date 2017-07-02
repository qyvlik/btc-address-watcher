import space.qyvlik.sqml 1.0

CrudService {
    id: listenBtcAddressService
    __dao: ListenBtcAddressDao {
        __connection: listenBtcAddressService.connection
        debug: listenBtcAddressService.debug
    }
}
