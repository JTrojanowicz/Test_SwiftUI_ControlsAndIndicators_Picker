//
//  ContentView.swift
//  Test_SwiftUI_ControlsAndIndicators_Picker
//
//  Created by Jaroslaw Trojanowicz on 08/09/2022.
//

import SwiftUI

enum Topping: String, CaseIterable, Identifiable {
    case nuts, cookies, blueberries
    var id: Self { self }
}

enum Flavor: String, CaseIterable, Identifiable {
    case chocolate, vanilla, strawberry
    var id: Self { self }
}

extension Flavor {
    var suggestedTopping: Topping {
        switch self {
        case .chocolate: return .nuts
        case .vanilla: return .cookies
        case .strawberry: return .blueberries
        }
    }
}

struct ContentView: View {
    
    @State private var selectedFlavor: Flavor = .chocolate
    @State private var suggestedTopping: Topping = .nuts
    
    var body: some View {
        VStack {
            List {
                Section {
                    // NOTE: the tags must correspond do the selection in Picker
                    Picker("Flavor", selection: $selectedFlavor) {
                        Text("Chocolate").tag(Flavor.chocolate)
                        Text("Vanilla").tag(Flavor.vanilla)
                        Text("Strawberry").tag(Flavor.strawberry)
                    }
                }
                // NOTE: You can add pickerStyle modifier outside an outer view (in this case outside Section) and that would apply to all pickers in it
//                .pickerStyle(.automatic)
//                .pickerStyle(.segmented)
//                .pickerStyle(.wheel)
//                .pickerStyle(.inline) // NOTE: it works in Lists
                .pickerStyle(.menu) // NOTE: in List it is the same as automatic but the color is different
                
                Section {
                    // NOTE: the tags must correspond do the selection in Picker (here ForEach iterates through the cases of Flavor, but the tags correspond to the selection variable)
                    Picker("Flavor", selection: $suggestedTopping) {
                        ForEach(Flavor.allCases) { flavor in
                            Text(flavor.rawValue.capitalized)
                                .tag(flavor.suggestedTopping)
                        }
                    }
//                    .pickerStyle(.automatic)
//                    .pickerStyle(.segmented)
//                    .pickerStyle(.wheel)
//                    .pickerStyle(.inline) // NOTE: it works in Lists
//                    .pickerStyle(.menu) // NOTE: in List it is the same as automatic but the color is different
                    
                    HStack {
                        Text("Suggested Topping")
                        Spacer()
                        Text(suggestedTopping.rawValue.capitalized)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            // NOTE: Picker outside of List does not show the label
            Picker("Flavor", selection: $selectedFlavor) {
                ForEach(Flavor.allCases) { flavor in
                    Text(flavor.rawValue.capitalized)
                }
            }
//            .pickerStyle(.automatic)
//            .pickerStyle(.segmented)
//            .pickerStyle(.wheel)
//            .pickerStyle(.inline) // NOTE: it does not work outside List
//            .pickerStyle(.menu) // NOTE: it is same as automatic outside List (while inside List automatic would have different color)
            
//            Spacer().padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
