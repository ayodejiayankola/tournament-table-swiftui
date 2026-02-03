import Foundation

struct StandingsColumn: Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let alignment: ContentAlignment
    let width: Double
    
    enum ContentAlignment: Equatable, Hashable {
        case leading
        case center
        case trailing
    }
}

enum StandingsColumns {
    static let standard: [StandingsColumn] = [
        .init(id: "mp", title: "Matches Played", alignment: .center, width: 120),
        .init(id: "w", title: "Wins", alignment: .center, width: 80),
        .init(id: "d", title: "Draws", alignment: .center, width: 80),
        .init(id: "l", title: "Losses", alignment: .center, width: 80),
        .init(id: "gf", title: "Goals Scored", alignment: .center, width: 120),
        .init(id: "ga", title: "Goals Against", alignment: .center, width: 130),
        .init(id: "gd", title: "Goal Difference", alignment: .center, width: 140),
        .init(id: "pts", title: "Points", alignment: .center, width: 90),
        .init(id: "form", title: "Last 5", alignment: .center, width: 120),
    ]
}
