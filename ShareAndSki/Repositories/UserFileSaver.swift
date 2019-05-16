import Foundation
import ObjectMapper

class UserFileSaver {
    private let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    private let fileManager = FileManager.default
    private let fileURL: URL
    private let fileName: String


    init(fileName: String = "user") {
        self.fileName = fileName
        self.fileURL = documentsURL.appendingPathComponent(fileName)
    }

    func save(user: UserWithToken) {
        guard let data = Mapper<UserWithToken>().toJSONString(user)?.data(using: .utf8) else {
            return
        }
        do {
            try data.write(to: fileURL, options: .noFileProtection)
        } catch {
            print("[ClickedButtonFileSaver] Could not create data from clicked button array")
        }
    }

    func read() -> UserWithToken? {
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                guard let string = String(data: data, encoding: .utf8),
                      let user = Mapper<UserWithToken>().map(JSONString: string) else {
                    return nil
                }
                return user
            } catch {
                print("[ClickedButtonFileSaver] Could not get data")
            }
        }
        return nil
    }

    func clear() {
        do {
            try fileManager.removeItem(at: fileURL)
        } catch {
            print("[ClickedButtonFileSaver] Could not remove data")
        }
    }

}