//
//  Client.swift
//  ComicList
//
//  Created by Michel Barbou Salvador on 08/10/16.
//  Copyright © 2016 Guillermo Gonzalez. All rights reserved.
//

import Foundation
import HTTPFetcher
import RxSwift

private let baseURL = URL(string: "http://www.comicvine.com/api")!

private let key = "44553b2f812d454416f52820bc00d86338b21854"

public enum ClientError: Error {
    case couldNotDecodeJSON
    case badStatus(Int, String)
}

public final class Client {
    
    private let fetcher: HTTPFetcher
    
    public init(fetcher: HTTPFetcher = URLSession(configuration: URLSessionConfiguration.default)) {
        
        self.fetcher = fetcher
    }
    
    public func objects<T: JSONDecodable>(forResource resource: Resource) -> Observable<[T]> {
        return response(forResource: resource)
            .map { response in
                guard let results: [T] = response.results() else {
                    throw ClientError.couldNotDecodeJSON
                }
                
                return results
        }
    }
    
    public func object<T: JSONDecodable>(forResource resource: Resource) -> Observable<T> {
        return response(forResource: resource)
            .map { response in
                guard let result: T = response.result() else {
                    throw ClientError.couldNotDecodeJSON
                }
                
                return result
            }
    }
    
    private func response(forResource resource: Resource) -> Observable<Response> {
        
        let request = resource.request(withBaseURL: baseURL, additionalParameters: ["api_key": key])
        
        return fetcher.data(request: request)
            .map {data in
                guard let response: Response = decode(data) else {
                    throw ClientError.couldNotDecodeJSON
                }
                
                guard response.succeeded else {
                    throw ClientError.badStatus(response.status, response.message)
                }
                
                return response
            }
    }
}
