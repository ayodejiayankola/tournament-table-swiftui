import SwiftUI


struct Hairline: View {
    enum Direction { case horizontal, vertical }
    var direction: Direction
    var color: Color = AppTheme.separator
    
    @Environment(\.displayScale) private var displayScale
    private var thickness: CGFloat { 1 / max(displayScale, 1)}
    
    init(color: Color = AppTheme.separator, _ direction: Direction) {
        self.color = color
        self.direction = direction
    }
    
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: direction == .vertical ? thickness : nil,
                   height: direction == .horizontal ? thickness : nil)
            .accessibilityHidden(true)
    }
}

#Preview("Horizontal") {
    Hairline(color: AppTheme.separator, .horizontal)
}

#Preview("Vertical") {
    Hairline(color: AppTheme.separator, .vertical)
}
