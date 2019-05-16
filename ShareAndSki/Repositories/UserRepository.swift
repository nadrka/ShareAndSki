import Foundation

class UserRepository {
    private(set) var userWithToken: UserWithToken?
    private let fileSaver: UserFileSaver
    static let shared = UserRepository()

    init(fileSaver: UserFileSaver = UserFileSaver()) {
        self.fileSaver = fileSaver
        userWithToken = fileSaver.read()
    }

    func save(user: UserWithToken) {
        fileSaver.save(user: user)
    }

    func update(user: UserWithToken) {
        fileSaver.save(user: user)
    }

    func read() -> UserWithToken? {
        return fileSaver.read()
    }

    func clear() {
        fileSaver.clear()
    }

}