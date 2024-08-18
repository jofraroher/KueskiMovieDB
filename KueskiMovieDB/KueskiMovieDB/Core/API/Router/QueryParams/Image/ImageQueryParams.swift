//
//  ImageQueryParams.swift
//  KueskiMovieDB
//
//  Created by Francisco Rosales on 18/08/24.
//

protocol ImageQueryParamsProtocol {
    var imageSize: ImageSizeType { get }
    var imagePath: String { get }
}

struct ImageQueryParams: ImageQueryParamsProtocol {
    
    let imageSize: ImageSizeType = .medium
    
    let imagePath: String
}
