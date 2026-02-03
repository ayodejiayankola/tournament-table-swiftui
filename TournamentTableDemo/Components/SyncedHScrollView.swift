import SwiftUI
import UIKit

struct SyncedHScrollView<Content: View>: UIViewRepresentable {

    @Binding var offsetX: CGFloat
    var showsIndicators: Bool = true
    var content: () -> Content

    init(offsetX: Binding<CGFloat>, showsIndicators: Bool = true, @ViewBuilder content: @escaping () -> Content) {
        self._offsetX = offsetX
        self.showsIndicators = showsIndicators
        self.content = content
    }

    func makeCoordinator() -> Coordinator { Coordinator(parent: self) }

    func makeUIView(context: Context) -> UIScrollView {
        let scroll = UIScrollView()
        scroll.showsHorizontalScrollIndicator = showsIndicators
        scroll.showsVerticalScrollIndicator = false
        scroll.alwaysBounceHorizontal = true
        scroll.alwaysBounceVertical = false
        scroll.bounces = true
        scroll.delegate = context.coordinator
        scroll.contentInsetAdjustmentBehavior = .never
        scroll.decelerationRate = .normal
        scroll.isDirectionalLockEnabled = true
        scroll.clipsToBounds = true

        let host = UIHostingController(rootView: content())
        host.view.backgroundColor = .clear
        host.view.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(host.view)

        NSLayoutConstraint.activate([
            host.view.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor),
            host.view.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor),
            host.view.heightAnchor.constraint(equalTo: scroll.frameLayoutGuide.heightAnchor)
        ])

        context.coordinator.scrollView = scroll
        context.coordinator.hostingController = host
        return scroll
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.hostingController?.rootView = content()
        if abs(uiView.contentOffset.x - offsetX) > 1.0, !context.coordinator.programmaticScroll {
            context.coordinator.programmaticScroll = true
            uiView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
            context.coordinator.programmaticScroll = false
        }
    }

    final class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: SyncedHScrollView
        weak var scrollView: UIScrollView?
        var hostingController: UIHostingController<Content>?
        var programmaticScroll = false

        init(parent: SyncedHScrollView) { self.parent = parent }

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard !programmaticScroll else { return }
            parent.offsetX = scrollView.contentOffset.x
        }
    }
}
