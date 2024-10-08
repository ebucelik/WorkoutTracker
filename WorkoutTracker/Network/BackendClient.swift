//
//  BackendClient.swift
//  WorkoutTracker
//
//  Created by Ing. Ebu Celik, BSc on 15.01.24.
//

import Foundation
import Combine

class BackendClient {

    func sendRequest<C: Call>(call: C) async throws -> C.Response {
        return try await withCheckedThrowingContinuation { continuation in
            sendRequest(call: call) { result in
                switch result {
                case let .failure(error):
                    if let apiError = error as? APIError {
                        continuation.resume(throwing: apiError)
                    } else {
                        continuation.resume(throwing: error)
                    }

                case let .success(model):
                    continuation.resume(returning: model)
                }
            }
        }
    }

    private func sendRequest<C: Call>(call: C, completion: @escaping (Result<C.Response, Error>) -> Void) {

        // MARK: - Create URLComponents
        guard var components = URLComponents(string: call.path) else {
            completion(.failure(APIError.unexpectedError("URLCompontens are not valid or empty.")))
            return
        }

        if let parameters = call.parameters {
            components.queryItems = parameters.compactMap { (key, value) in
                if let valueString = value as? String {
                    return URLQueryItem(name: key, value: valueString)
                }

                if let valueInt = value as? Int {
                    return URLQueryItem(name: key, value: String(valueInt))
                }

                return nil
            }

            components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        }

        guard let url = components.url else {
            completion(.failure(APIError.unexpectedError("URL is not valid or empty.")))
            return
        }

        let request = createRequest(
            for: url,
            call: call
        )

#if DEBUG
        print("\nREQUEST URL: \(String(describing: url.absoluteString))")
#endif
        // MARK: Start call
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("\nERROR: \(error)")
                completion(.failure(error))
            } else {
                if let data = data {
                    print("DATA: \(String(decoding: data, as: UTF8.self))\n")
                }

                if let response = response as? HTTPURLResponse,
                   let headerFields = response.allHeaderFields as? [String: String],
                   let url = response.url {
                    let cookies: [HTTPCookie] = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
                    HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                }

                self.handleResponse(
                    with: response,
                    call: call,
                    data: data,
                    completion
                )
            }
        }
        .resume()
    }

    private func handleResponse<C: Call>(with response: URLResponse?,
                                         call: C,
                                         data: Data?,
                                         _ completion: @escaping (Result<C.Response, Error>) -> Void) {
        if let data = data,
           let response = response as? HTTPURLResponse {
            if self.isStatusCodeValid(response.statusCode) {
                do {
                    let model = try JSONDecoder().decode(C.Response.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            } else if response.statusCode == 401 {
                do {
                    let model = try JSONDecoder().decode(Message.self, from: data)
                    completion(.failure(APIError.unauthorized(model)))
                } catch {
                    completion(.failure(APIError.unauthorized(nil)))
                }
            } else {
                do {
                    let model = try JSONDecoder().decode(Message.self, from: data)
                    completion(.failure(APIError.unknown(model)))
                } catch {
                    completion(.failure(APIError.unknown(nil)))
                }
            }
        } else {
            completion(.failure(APIError.unexpectedError("Data is corrupt.")))
        }
    }

    /// Creates an URLRequest object.
    /// - Parameters:
    ///   - url: To insert or get an object to or from the backend.
    ///   - httpMethod: Define the http method (e.g. GET, POST, PUT, DELETE).
    ///   - body: When a object should be inserted or updated at the backend.
    /// - Returns: URLRequest object
    private func createRequest(for url: URL, call: any Call) -> URLRequest {
        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = call.httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = call.body {
            urlRequest.httpBody = try? JSONEncoder().encode(body)
        }

        return urlRequest
    }
}

extension BackendClient {
    private func isStatusCodeValid(_ code: Int) -> Bool {
        (200..<399).contains(code)
    }
}
