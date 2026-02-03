import Foundation

enum SampleData {
    
    static let premierLeagueTable: TournamentTable = {
        let rows: [TournamentTableRow] = [
            .init(id: "1", position: 1, club: .init(name: "Liverpool", shortName: "LIV"), matchesPlayed: 25, wins: 18, draws: 6, losses: 1, goalsScored: 60, goalsAgainst: 24, points: 60, form: [.win, .win, .win, .draw, .win]),
            .init(id: "2", position: 2, club: .init(name: "Arsenal", shortName: "ARS"), matchesPlayed: 25, wins: 15, draws: 8, losses: 2, goalsScored: 51, goalsAgainst: 22, points: 53, form: [.win, .draw, .win, .win, .win]),
            .init(id: "3", position: 3, club: .init(name: "Nottm Forest", shortName: "NFO"), matchesPlayed: 25, wins: 14, draws: 5, losses: 6, goalsScored: 41, goalsAgainst: 29, points: 47, form: [.draw, .win, .loss, .win, .loss]),
            .init(id: "4", position: 4, club: .init(name: "Man City", shortName: "MCI"), matchesPlayed: 25, wins: 13, draws: 5, losses: 7, goalsScored: 52, goalsAgainst: 35, points: 44, form: [.draw, .win, .win, .loss, .win]),
            .init(id: "5", position: 5, club: .init(name: "Bournemouth", shortName: "BOU"), matchesPlayed: 25, wins: 12, draws: 7, losses: 6, goalsScored: 44, goalsAgainst: 29, points: 43, form: [.draw, .win, .win, .loss, .win]),
            .init(id: "6", position: 6, club: .init(name: "Chelsea", shortName: "CHE"), matchesPlayed: 25, wins: 12, draws: 7, losses: 6, goalsScored: 47, goalsAgainst: 34, points: 43, form: [.draw, .win, .loss, .win, .loss]),
            .init(id: "7", position: 7, club: .init(name: "Newcastle", shortName: "NEW"), matchesPlayed: 25, wins: 12, draws: 5, losses: 8, goalsScored: 42, goalsAgainst: 33, points: 41, form: [.win, .loss, .win, .loss, .loss]),
            .init(id: "8", position: 8, club: .init(name: "Fulham", shortName: "FUL"), matchesPlayed: 25, wins: 10, draws: 9, losses: 6, goalsScored: 38, goalsAgainst: 33, points: 39, form: [.loss, .win, .loss, .win, .win]),
            .init(id: "9", position: 9, club: .init(name: "Aston Villa", shortName: "AVL"), matchesPlayed: 25, wins: 10, draws: 8, losses: 7, goalsScored: 35, goalsAgainst: 38, points: 38, form: [.win, .draw, .draw, .loss, .draw]),
            .init(id: "10", position: 10, club: .init(name: "Brighton", shortName: "BHA"), matchesPlayed: 25, wins: 9, draws: 10, losses: 6, goalsScored: 38, goalsAgainst: 38, points: 37, form: [.win, .win, .loss, .loss, .win]),
            .init(id: "11", position: 11, club: .init(name: "Brentford", shortName: "BRE"), matchesPlayed: 25, wins: 10, draws: 4, losses: 11, goalsScored: 43, goalsAgainst: 42, points: 34, form: [.draw, .loss, .win, .loss, .win]),
            .init(id: "12", position: 12, club: .init(name: "Tottenham", shortName: "TOT"), matchesPlayed: 25, wins: 9, draws: 3, losses: 13, goalsScored: 49, goalsAgainst: 37, points: 30, form: [.loss, .loss, .loss, .win, .win]),
            .init(id: "13", position: 13, club: .init(name: "Crystal Palace", shortName: "CRY"), matchesPlayed: 25, wins: 7, draws: 9, losses: 9, goalsScored: 29, goalsAgainst: 32, points: 30, form: [.win, .win, .loss, .win, .loss]),
            .init(id: "14", position: 14, club: .init(name: "Everton", shortName: "EVE"), matchesPlayed: 25, wins: 7, draws: 9, losses: 9, goalsScored: 27, goalsAgainst: 31, points: 30, form: [.win, .win, .win, .draw, .win]),
            .init(id: "15", position: 15, club: .init(name: "Man United", shortName: "MUN"), matchesPlayed: 25, wins: 8, draws: 5, losses: 12, goalsScored: 28, goalsAgainst: 35, points: 29, form: [.win, .loss, .win, .loss, .loss]),
            .init(id: "16", position: 16, club: .init(name: "West Ham", shortName: "WHU"), matchesPlayed: 25, wins: 7, draws: 6, losses: 12, goalsScored: 29, goalsAgainst: 47, points: 27, form: [.win, .loss, .draw, .loss, .loss]),
            .init(id: "17", position: 17, club: .init(name: "Wolves", shortName: "WOL"), matchesPlayed: 25, wins: 5, draws: 4, losses: 16, goalsScored: 35, goalsAgainst: 54, points: 19, form: [.loss, .loss, .loss, .win, .loss]),
            .init(id: "18", position: 18, club: .init(name: "Ipswich Town", shortName: "IPS"), matchesPlayed: 25, wins: 3, draws: 8, losses: 14, goalsScored: 23, goalsAgainst: 50, points: 17, form: [.loss, .loss, .loss, .loss, .draw]),
            .init(id: "19", position: 19, club: .init(name: "Leicester City", shortName: "LEI"), matchesPlayed: 25, wins: 4, draws: 5, losses: 16, goalsScored: 25, goalsAgainst: 55, points: 17, form: [.loss, .loss, .win, .loss, .loss]),
            .init(id: "20", position: 20, club: .init(name: "Southampton", shortName: "SOU"), matchesPlayed: 25, wins: 2, draws: 3, losses: 20, goalsScored: 19, goalsAgainst: 57, points: 9, form: [.loss, .loss, .loss, .win, .loss])
        ]
        
        return TournamentTable(
            competitionName: "Premier League",
            season: "2025/26",
            rows: rows)
    }()
}
