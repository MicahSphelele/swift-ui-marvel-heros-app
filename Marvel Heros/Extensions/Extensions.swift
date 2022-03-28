//
//  Extensions.swift
//  Marvel Heros
//
//  Created by Sphelele Ngubane on 2022/03/28.
//

import Foundation

extension URLSession {
    
    func request<T: Codable>(
                url: URL?,
                expecting: T.Type,
                completion: @escaping (Result<T, Error>) -> Void) {

                    guard let url = url else {
                        completion(.failure(NetworkError.invalidUrl))
                        return
                    }
                    
                    let task = dataTask(with: url) { data, _, error in
                        
                        guard let data =  data else {
                            if let error = error {
                                DispatchQueue.main.async {
                                    completion(.failure(error))
                                }
                            } else {
                                DispatchQueue.main.async {
                                    completion(.failure(NetworkError.invalidData))
                                }
                            }
                            return
                        }
                        
                        do {
                            let result = try JSONDecoder().decode(expecting, from: data)
                            DispatchQueue.main.async {
                                completion(.success(result))
                            }
                            
                        } catch {
                            DispatchQueue.main.async {
                                completion(.failure(error))
                            }
                        }
                    }
                    task.resume()
           
       }
}
