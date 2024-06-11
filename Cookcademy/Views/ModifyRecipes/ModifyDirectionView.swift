//
//  ModifyDirectionView.swift
//  Cookcademy
//
//  Created by Cosmin Gradinariu on 26.04.2024.
//

import SwiftUI

struct ModifyDirectionView: ModifyComponentView {
    @Binding var direction: Direction
    var createAction: (Direction) -> Void
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    init(component: Binding<Direction>, createAction: @escaping (Direction) -> Void) {
        self._direction = component
        self.createAction = createAction
    }
    
    @Environment(\.presentationMode) private var mode
    
    var body: some View {
        Form {
            TextField("Input direction", text: $direction.description)
                .listRowBackground(listBackgroundColor)
            Toggle("Optional", isOn: $direction.isOptional)
                .listRowBackground(listBackgroundColor)
            HStack {
                Spacer()
                Button("Save") {
                    createAction(direction)
                    mode.wrappedValue.dismiss()
                }
                Spacer()
            }.listRowBackground(listBackgroundColor)
        }
        .foregroundStyle(listTextColor)
    }
}

#Preview {
    @State var emptyDirection = Direction(description: "", isOptional: false)
   return NavigationView {
        ModifyDirectionView(component: $emptyDirection) { _ in return }
    }
}
