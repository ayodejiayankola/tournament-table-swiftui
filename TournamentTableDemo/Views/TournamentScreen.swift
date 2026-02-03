import SwiftUI

struct TournamentScreen: View {
    var body: some View {
        TournamentTableView(
            table: SampleData.premierLeagueTable,
            columns: StandingsColumns
                .standard)
    }
}

#Preview {
    TournamentScreen()
}
