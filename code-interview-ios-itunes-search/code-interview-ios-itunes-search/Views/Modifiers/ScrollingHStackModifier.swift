//
//  ScrollingHStackModifier.swift
//  code-interview-ios-itunes-search
//
//  Created by Martin on 2023/08/24.
//
import SwiftUI

struct ScrollingHStackModifier: ViewModifier {
    enum SnapMode {
        case center
        case leading
    }
    
    @State private var scrollOffset: CGFloat
    @State private var dragOffset: CGFloat
    
    var items: Int
    var itemWidth: CGFloat
    var itemSpacing: CGFloat
    var snapMode: SnapMode
    var initialIndex: Int
    
    
    init(snapMode: SnapMode, items: Int, itemWidth: CGFloat, itemSpacing: CGFloat = 16, initialIndex: Int = 0) {
        self.snapMode = snapMode
        self.items = items
        self.itemWidth = itemWidth
        self.itemSpacing = itemSpacing
        self.initialIndex = initialIndex
        
        // 전체의 너비를 구한다.
        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
        let screenWidth = UIScreen.main.bounds.width
        
        // 전체 너비의 절반을 오른쪽으로 움직이고
        // 화면크기의 절반 만큼 왼쪽으로 움직이면
        // HStack의 프레임 x값이 0이 된다.
        // 이때 아이템의 너비와 화면 너비의 차의 절반만큼 오른쪽으로 다시 조정하면 첫번재 아이템이 가운데 정렬
        // 아이템 간격만큼 오른쪽으로 움직이면 아이템이 왼쪽 화면 여백 바로 뒤에 붙어있는 것처럼 보이게 된다.
        let adjustmentOffset = snapMode == .center ? (screenWidth - itemWidth) / 2.0 : itemSpacing
        let initialOffset = (contentWidth/2.0) - (screenWidth/2.0) + adjustmentOffset
        
        self._scrollOffset = State(initialValue: initialOffset)
        self._dragOffset = State(initialValue: 0)
    }
    
    func body(content: Content) -> some View {
        content
            .offset(x: scrollOffset + dragOffset, y: 0)
            .gesture(
                DragGesture()
                    .onChanged{ event in
                        dragOffset = event.translation.width
                    }
                    .onEnded { event in
                        // Scroll to where user dragged
                        scrollOffset += event.translation.width
                 
                        dragOffset = 0
                        
                        // Now calculate which item to snap to
                        let contentWidth: CGFloat = CGFloat(items) * itemWidth + CGFloat(items - 1) * itemSpacing
                        let screenWidth = UIScreen.main.bounds.width
                        
                        // Center position of current offset
                        let center = scrollOffset  + (contentWidth / 2.0)
                        
                        // Calculate which item we are closest to using the defined size
                        var index = center / (itemWidth + itemSpacing)
                        
                        // Should we stay at current index or are we closer to the next item...
                        if index.remainder(dividingBy: 1) > 0.5 {
                            index += 1
                        } else {
                            index = CGFloat(Int(index))
                        }
                        
                        // Protect from scrolling out of bounds
                        index = min(index, CGFloat(items) - 1)
                        index = max(index, 0)
                        
                        // MARK: - 마지막 위치 정하기
                        // 현재 인덱스 오른쪽 너비
                        // 인덱스 크기는 오른쪽이 제일 작음
                        // [2] [1] [0]
                        let rightWidth = index * itemWidth + index * itemSpacing
                        var adjustmentOffset: CGFloat
                        switch snapMode {
                        case .center: adjustmentOffset = (screenWidth - itemWidth) / 2.0
                        case .leading where index == 0: adjustmentOffset = itemSpacing
                        case .leading: adjustmentOffset = (screenWidth - itemWidth) - itemSpacing
                        }
                        let initialOffset = (contentWidth / 2.0) - (screenWidth / 2.0) + adjustmentOffset
                        
                        let newOffset = rightWidth - initialOffset
                        
                        // Animate snapping
                        withAnimation(.easeInOut) {
                            scrollOffset = newOffset
                        }
                        
                    }
            )
    }
}

extension View {
    func scrollingHStack(_ snapMode: ScrollingHStackModifier.SnapMode, items: Int, itemWidth: CGFloat, spacing: CGFloat) -> some View {
        modifier(ScrollingHStackModifier(snapMode: snapMode, items: items, itemWidth: itemWidth, itemSpacing: spacing))
    }
}
