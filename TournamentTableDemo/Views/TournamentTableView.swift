import SwiftUI

struct TournamentTableView: View {
    
    // MARK: Inputs
    let table: TournamentTable
    let columns: [StandingsColumn]
    
    // MARK: Environment
    @Environment(\.horizontalSizeClass) private var hSizeClass
    @Environment(\.displayScale) private var displayScale
    
    // MARK: Layout constants
    private let positionWidth: CGFloat = 90
    private let clubWidth: CGFloat = 110
    private let headerHeight: CGFloat = 44
    private let rowHeight: CGFloat = 84
    private let rightPadding: CGFloat = 48
    
    private var hairlineThickness: CGFloat { 1 / max(displayScale, 1) }
    @State private var rightOffsetX: CGFloat = 0
    
    // MARK: Body
    var body: some View {
        GeometryReader { geometry in
            
            let leftWidth = positionWidth + clubWidth + hairlineThickness
            let availableRight = max(0, geometry.size.width - leftWidth - hairlineThickness)
            
            let baseColumnsWidth = CGFloat(columns.map { $0.width }.reduce(0, +))
            let scale = max(1, availableRight / max(baseColumnsWidth, 1))
            
            let showIndicators = hSizeClass == .compact
            
            ZStack {
                AppTheme.background.ignoresSafeArea(edges: .bottom)
                
                VStack(spacing: 0) {
                    
                    // MARK: Header (sticky)
                    HStack(spacing: 0) {
                        leftHeader
                            .frame(width: leftWidth)
                        
                        Hairline(.vertical)
                        
                        rightHeader(scale: scale, showIndicators: showIndicators)
                            .frame(height: headerHeight)
                    }
                    .frame(height: headerHeight)
                    
                    Hairline(.horizontal)
                    
                    // MARK: Rows (vertical scroll)
                    ScrollView(.vertical, showsIndicators: false) {
                        ZStack(alignment: .topLeading) {
                            
                            HStack(spacing: 0) {
                                leftBody
                                    .frame(width: leftWidth)
                                
                                Hairline(.vertical)
                                
                                rightBody(scale: scale, showIndicators: showIndicators)
                            }
                            
                            // Horizontal separators spanning the full width
                            VStack(spacing: 0) {
                                ForEach(0..<table.rows.count, id: \.self) { _ in
                                    Spacer().frame(height: rowHeight)
                                    Hairline(.horizontal)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .allowsHitTesting(false)
                        }
                    }
                    .scrollIndicators(.hidden, axes: .vertical)
                    .scrollBounceBehavior(.basedOnSize)
                }
                .padding(.leading, 16)
            }
        }
    }
    
    // MARK: Left header
    private var leftHeader: some View {
        HStack(spacing: 0) {
            headerCell(text: "Position", width: positionWidth, alignment: .bottomLeading)
                .padding(.leading, 4)
            
            Hairline(.vertical)
            
            headerCell(text: "Club", width: clubWidth, alignment: .bottomLeading)
        }
    }
    
    // MARK: Right header (synced horizontal scroll)
    private func rightHeader(scale: CGFloat, showIndicators: Bool) -> some View {
        SyncedHScrollView(offsetX: $rightOffsetX, showsIndicators: showIndicators) {
            HStack(spacing: 0) {
                ForEach(Array(columns.enumerated()), id: \.element.id) { index, column in
                    if index > 0 { Hairline(.vertical) }
                    
                    headerCell(
                        text: column.title,
                        width: CGFloat(column.width) * scale,
                        alignment: headerBottomAlignmentFor(column.alignment)
                    )
                }
            }
            .padding(.trailing, rightPadding)
            .frame(
                minWidth: (CGFloat(columns.map { $0.width }.reduce(0, +)) * scale)
                + (CGFloat(max(columns.count - 1, 0)) * hairlineThickness)
                + rightPadding,
                alignment: .leading
            )
        }
    }
    
    // MARK: Left body (sticky columns)
    private var leftBody: some View {
        LazyVStack(spacing: 0) {
            ForEach(table.rows) { row in
                HStack(spacing: 0) {
                    
                    dataCell(text: "\(row.position)", width: positionWidth)
                        .accessibilityLabel("Position: \(row.position)")
                    
                    Hairline(.vertical)
                    
                    dataCell(
                        text: row.club.name,
                        width: clubWidth,
                        alignment: Alignment(horizontal: .leading, vertical: .bottom)
                    )
                    .accessibilityLabel("Club: \(row.club.name)")
                }
                .frame(height: rowHeight)
                .accessibilityElement(children: .combine)
            }
        }
    }
    
    // MARK: Right body (synced horizontal scroll)
    private func rightBody(scale: CGFloat, showIndicators: Bool) -> some View {
        SyncedHScrollView(offsetX: $rightOffsetX, showsIndicators: showIndicators) {
            LazyVStack(spacing: 0) {
                ForEach(table.rows) { row in
                    HStack(spacing: 0) {
                        ForEach(Array(columns.enumerated()), id: \.element.id) { index, column in
                            if index > 0 { Hairline(.vertical) }
                            
                            if column.id == "form" {
                                formCell(row.form, width: CGFloat(column.width) * scale)
                            } else {
                                dataCell(
                                    text: cellValue(for: column, row: row),
                                    width: CGFloat(column.width) * scale,
                                    alignment: bottomAlignmentFor(column.alignment)
                                )
                                .accessibilityLabel("\(column.title): \(cellValue(for: column, row: row))")
                            }
                        }
                    }
                    .padding(.trailing, rightPadding)
                    .frame(height: rowHeight)
                }
            }
            .frame(
                minWidth: (CGFloat(columns.map { $0.width }.reduce(0, +)) * scale)
                + (CGFloat(max(columns.count - 1, 0)) * hairlineThickness)
                + rightPadding,
                alignment: .leading
            )
        }
    }
    
    // MARK: Cell rendering
    private func headerCell(text: String, width: CGFloat, alignment: Alignment) -> some View {
        Text(text)
            .font(.system(size: 13, weight: .semibold))
            .frame(width: width, height: headerHeight, alignment: alignment)
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .accessibilityAddTraits(.isHeader)
    }
    
    private func dataCell(
        text: String,
        width: CGFloat,
        alignment: Alignment = .bottom
    ) -> some View {
        Text(text)
            .font(.system(size: 14))
            .monospacedDigit()
            .frame(width: width, height: rowHeight, alignment: alignment)
            .padding(.horizontal, 8)
            .padding(.bottom, 10)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
    }
    
    private func formCell(_ form: [FormResult], width: CGFloat) -> some View {
        VStack(alignment: .center, spacing: 2) {
            ForEach(form.indices, id: \.self) { i in
                Text(form[i].rawValue)
                    .font(.system(size: 12, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
        }
        .frame(width: width, height: rowHeight, alignment: .bottom)
        .padding(.horizontal, 8)
        .padding(.bottom, 10)
        .accessibilityLabel("Last 5: \(form.map { $0.rawValue }.joined(separator: ", "))")
    }
    
    // MARK: Helpers
    private func cellValue(for column: StandingsColumn, row: TournamentTableRow) -> String {
        switch column.id {
        case "mp": return "\(row.matchesPlayed)"
        case "w": return "\(row.wins)"
        case "d": return "\(row.draws)"
        case "l": return "\(row.losses)"
        case "gf": return "\(row.goalsScored)"
        case "ga": return "\(row.goalsAgainst)"
        case "gd": return "\(row.goalDifference)"
        case "pts": return "\(row.points)"
        case "form": return ""
        default: return ""
        }
    }
    
    private func bottomAlignmentFor(_ a: StandingsColumn.ContentAlignment) -> Alignment {
        switch a {
        case .leading: return Alignment(horizontal: .leading, vertical: .bottom)
        case .center: return Alignment(horizontal: .center, vertical: .bottom)
        case .trailing: return Alignment(horizontal: .trailing, vertical: .bottom)
        }
    }
    
    private func headerBottomAlignmentFor(_ a: StandingsColumn.ContentAlignment) -> Alignment {
        switch a {
        case .leading: return .bottomLeading
        case .center: return .bottom
        case .trailing: return .bottomTrailing
        }
    }
}

#Preview {
    TournamentTableView(
        table: SampleData.premierLeagueTable,
        columns: StandingsColumns.standard
    )
}
