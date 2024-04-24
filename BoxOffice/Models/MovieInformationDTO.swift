//
//  MovieInformationDTO.swift
//  BoxOffice
//
//  Created by Danny, Diana, gama on 4/23/24.
//

import Foundation

struct MovieInformationDetailDTO {
    let movieName: String
    let productYear: String
    let showTime: String
    let openDate: String
    let nations: [NationDTO]
    let genres: [GenreDTO]
    let directors: [DirectorDTO]
    let actors: [ActorDTO]
    let audits: [AuditDTO]
}

struct NationDTO {
    let nationName: String
}

struct GenreDTO {
    let genreName: String
}

struct DirectorDTO {
    let peopleName: String
}

struct ActorDTO {
    let peopleName: String
}

struct AuditDTO {
    let watchGradeName: String
}
