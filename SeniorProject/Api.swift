import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit

class Api {
    
    static let api: Api = Api()
    let localStorage = UserDefaults.standard
    let baseURL: String = "http://192.168.1.202:3000/api"
    
    func login(username: String, password: String) -> Promise<Bool> {
        let parameters: [String: Any] = [
            "username": username,
            "password_hash": password
        ]
        
        return Promise{ fulfill, reject in
            Alamofire.request(baseURL + "/auth", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success:
                        fulfill(true)
                    case .failure(let error):
                        reject(error)
                        print(error)
                    }
            }
        }
    }
    
    func getAllQueues(with: String!) -> Promise<[Queue]> {
        let parameters: [String: Any] = [
            "name": with ?? ""
        ]
        
        return Promise { fulfill, reject in
            Alamofire.request(baseURL + "/queue",
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding.default)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
       
                        if let array = json["data"].array {
                            var queues: [Queue] = []
                            for item in array {
                                guard let dictionary = item.dictionaryObject else {
                                    continue
                                }
                                if let queue = Queue(data: dictionary) {
                                    print(queue.description)
                                    queues.append(queue)
                                }
                            }
                            fulfill(queues)
                        }
                    case .failure(let error):
                        reject(error)
                        print(error)
                    }
            }
        }
    }
    
    func getSelectedQueue(queue: Queue) -> Promise<Queue> {
        return Promise { fulfill, reject in
            Alamofire.request(baseURL + "/queue/\(queue.id)", method: .get)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json["data"]["Songs"])
                        if let array = json["data"]["Songs"].array {
                            var songs: [Song] = []
                            for item in array {
                                guard let dictionary = item.dictionaryObject else {
                                    continue
                                }
                                if let song = Song(data: dictionary) {
                                    print(song.description)
                                    queue.enqueue(song: song)
                                }
                            }
                            fulfill(queue)
                        }
                    case .failure(let error):
                        reject(error)
                        print(error)
                    }
            }
        }
    }
    
    func searchUsers(query: String) -> Promise<[User]> {
        let parameters: [String: Any] = [
            "search": query
        ]
        
        return Promise { fulfill, reject in
            Alamofire.request(baseURL + "/user",
                              method: .get,
                              parameters: parameters,
                              encoding: URLEncoding.default)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        
                        if let array = json["data"].array {
                            var users: [User] = []
                            for item in array {
                                guard let dictionary = item.dictionaryObject else {
                                    continue
                                }
                                if let user = User(data: dictionary) {
                                    users.append(user)
                                }
                            }
                            fulfill(users)
                        }
                    case .failure(let error):
                        reject(error)
                        print(error)
                    }
            }
        }
    }
    
    func createQueue(name: String, isPrivate: Bool, password: String, members: [User]) -> Promise<Bool> {
        
        let parameters: [String : Any] = [
            "name": name,
            "private": isPrivate,
            "password": password,
            "members": members.map { $0.id }
        ]
        
        return Promise { fulfill, reject in
            Alamofire.request(baseURL + "/queue", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success:
                    fulfill(true)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    func joinQueue(queueId: Int, password: String!) -> Promise<Bool> {
        
        var parameters: [String : Any] = [:]
        
        if password != nil {
            parameters["password"] = password!
        }
        
        return Promise{ fulfill, reject in
            Alamofire.request(baseURL + "/queue/\(queueId)/join", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .responseData { response in
                    switch response.result {
                    case .success:
                        fulfill(true)
                    case .failure(let error):
                        reject(error)
                        print(error)
                    }
            }
        }
    }
}