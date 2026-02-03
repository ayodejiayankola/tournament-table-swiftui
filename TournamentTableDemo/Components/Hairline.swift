import SwiftUI

struct Hairline: View {
    enum Direction { case horizontal, vertical }
    let direction: Direction
    let color: Color
    
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
