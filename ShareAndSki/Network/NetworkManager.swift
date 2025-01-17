import Alamofire
import ObjectMapper

enum Endpoints: String {
    case users = "users"
    case auth = "auth"
    case groups = "groups"
    case usersFriends = "users/%@/friends"
    case knownUsers = "users/%@/knownUsers"
    case userPosition = "users/%@/position"
    case userForGroup = "groups/%@/users"

    static func getFullUrl(endpoint: String) -> String {
        return BasicURL.basicURL.rawValue + endpoint
    }
}

fileprivate enum BasicURL: String {
    case basicURL = "https://share-and-ski.herokuapp.com/api/"
}


class NetworkManager {
    static let sharedInstance: NetworkManager = NetworkManager()

    func get(endpoint: String, parameters: [String: Any]?, onSuccess: @escaping ([String: Any]) -> (), onError: @escaping (String) -> ()) {
        let token = UserRepository.shared.userWithToken?.token
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token ?? ""
        ]
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    onError("Some problem occurred")
                    return
                }
                do {
                    guard let stringDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        return
                    }
                    onSuccess(stringDic)
                } catch {
                    onError("Decoding Error")
                    return
                }
            case .failure(let error):
                onError(error.localizedDescription)
                return
            }
        }
    }

    func getArray(endpoint: String, parameters: [String: Any]?, onSuccess: @escaping ([[String: Any]]) -> (), onError: @escaping (String) -> ()) {
        let token = UserRepository.shared.userWithToken?.token
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token ?? ""
        ]
        Alamofire.request(endpoint, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    onError("Some problem occurred")
                    return
                }
                do {
                    guard let stringDic = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                        return
                    }
                    onSuccess(stringDic)
                } catch {
                    onError("Decoding Error")
                    return
                }
            case .failure(let error):
                onError(error.localizedDescription)
                return
            }
        }
    }

    func post<T: Mappable>(endpoint: String, parameters: T, onSuccess: @escaping ([String: Any]) -> (), onError: @escaping (String) -> ()) {
        let token = UserRepository.shared.userWithToken?.token
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token ?? ""
        ]
        let params: Parameters = parameters.toJSON()
        Alamofire.request(endpoint, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    onError("Some problem occurred")
                    return
                }
                do {
                    guard let stringDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        onError("Some problem occurred")
                        return
                    }
                    onSuccess(stringDic)
                } catch {
                    onError("Decoding Error")
                    return
                }
            case .failure(let error):
                onError(error.localizedDescription)
                return
            }
        }
    }

    func put<T: Mappable>(endpoint: String, parameters: T, onSuccess: @escaping ([String: Any]) -> (), onError: @escaping (String) -> ()) {
        let token = UserRepository.shared.userWithToken?.token
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token ?? ""
        ]
        let params: Parameters = parameters.toJSON()
        Alamofire.request(endpoint, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    onError("Some problem occurred")
                    return
                }
                do {
                    guard let stringDic = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        onError("Some problem occurred")
                        return
                    }
                    onSuccess(stringDic)
                } catch {
                    onError("Decoding Error")
                    return
                }
            case .failure(let error):
                onError(error.localizedDescription)
                return
            }
        }
    }

    func delete(endpoint: String, parameters: [String: Any]?, onSuccess: @escaping () -> (), onError: @escaping (String) -> ()) {
        let token = UserRepository.shared.userWithToken?.token
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": token ?? ""
        ]
        Alamofire.request(endpoint, method: .delete, parameters: parameters, headers: headers).validate().responseJSON {
            response in
            switch response.result {
            case .success:
                onSuccess()
            case .failure(let error):
                onError(error.localizedDescription)
                return
            }
        }
    }

    func mapResponse<T: Mappable>(_ response: [String: Any]) -> T? {
        let result = Mapper<T>().map(JSON: response)
        return result
    }

    func mapResponseArray<T: Mappable>(_ response: [[String: Any]]) -> [T]? {
        let result = Mapper<T>().mapArray(JSONArray: response)
        return result
    }

}