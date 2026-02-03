import SwiftUI

struct ContentView: View {
    var body: some View {
        TournamentTableView(
            table: SampleData.premierLeagueTable,
            columns: StandingsColumns
                .standard)
    }
}

#Preview {
    ContentView()
}
