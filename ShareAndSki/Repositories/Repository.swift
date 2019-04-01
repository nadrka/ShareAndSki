import Foundation

protocol Repository {

    func save<T>(item: T)
    func save<T>(items: [T])
    func read<T>() -> [T]?
    func readAll<T>() -> T?
    func clear()
}

extension Repository {
    func save<T>(item: T) {

    }

    func save<T>(items: [T]) {

    }

    func read<T>() -> [T]? {
        return nil
    }

    func readAll<T>() -> T? {
        return nil
    }
}