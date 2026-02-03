import Foundation

struct TournamentTable: Codable, Equatable {
    let competitionName: String
    let season: String
    let rows: [TournamentTableRow]
}

struct TournamentTableRow: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let position: Int
    let club: ClubInfo
    let matchesPlayed: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let goalsScored: Int
    let goalsAgainst: Int
    let points: Int
    let form: [FormResult]
    var goalDifference: Int {
        goalsScored - goalsAgainst
    }
}

struct ClubInfo: Codable, Equatable, Hashable {
    let name: String
    let shortName: String?
}

enum FormResult: String, Codable {
    case win = "Win"
    case draw = "Draw"
    case loss = "Loss"
    
    var shortCode: String {
        switch self {
        case .win: return "W"
        case .draw: return "D"
        case .loss: return "L"
        }
    }
}

