import SwiftUI

enum SwipeDirection {
    case left, right
}

struct SwipeGestureModifier: ViewModifier {
    let onSwipe: (SwipeDirection) -> Void
    let threshold: CGFloat = 120

    @State private var offset: CGSize = .zero
    @State private var isDragging = false

    private var rotation: Double {
        Double(offset.width / 20)
    }

    private var swipeProgress: CGFloat {
        min(1.0, abs(offset.width) / threshold)
    }

    private var isRightSwipe: Bool {
        offset.width > 0
    }

    func body(content: Content) -> some View {
        content
            .offset(x: offset.width, y: offset.height * 0.3)
            .rotationEffect(.degrees(rotation))
            .scaleEffect(isDragging ? 1.02 : 1.0)
            .overlay(alignment: isRightSwipe ? .topLeading : .topTrailing) {
                swipeIndicator
            }
            .gesture(dragGesture)
            .animation(.interactiveSpring(response: 0.3), value: offset)
            .animation(.spring(response: 0.3), value: isDragging)
    }

    @ViewBuilder
    private var swipeIndicator: some View {
        if abs(offset.width) > 30 {
            Group {
                if isRightSwipe {
                    Label("¡SÍ!", systemImage: "star.fill")
                        .font(.system(size: 20, weight: .black))
                        .foregroundStyle(.jojoGold)
                        .padding(12)
                        .background(.jojoGold.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.jojoGold, lineWidth: 2)
                        }
                } else {
                    Label("PASO", systemImage: "xmark")
                        .font(.system(size: 20, weight: .black))
                        .foregroundStyle(.gray)
                        .padding(12)
                        .background(.gray.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(.gray, lineWidth: 2)
                        }
                }
            }
            .rotationEffect(.degrees(-rotation))
            .opacity(Double(swipeProgress))
            .padding(20)
            .transition(.opacity)
        }
    }

    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                offset = value.translation
                isDragging = true
            }
            .onEnded { value in
                isDragging = false
                if abs(value.translation.width) > threshold {
                    let direction: SwipeDirection = value.translation.width > 0 ? .right : .left
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                        offset = CGSize(
                            width: value.translation.width > 0 ? 500 : -500,
                            height: value.translation.height
                        )
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        onSwipe(direction)
                        offset = .zero
                    }
                } else {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        offset = .zero
                    }
                }
            }
    }
}

extension View {
    func swipeable(onSwipe: @escaping (SwipeDirection) -> Void) -> some View {
        modifier(SwipeGestureModifier(onSwipe: onSwipe))
    }
}
