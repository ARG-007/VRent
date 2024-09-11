//
//  LocationSelector.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct LocationFinder: View {
    @EnvironmentObject var model: Model
    @Binding var selectedLocation: Location?
    @State private var locationSearchText: String = ""
    
    let prompt: String
    private let onSubmit: ()->Void
    
    init(_ prompt: String, selection: Binding<Location?>, onSubmit: @escaping ()->Void = {}) {
        self._selectedLocation = selection
        self.onSubmit = onSubmit
        self.prompt = prompt
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(prompt)
                    .font(.title2.bold())
                    
                    
                locationSearchBar
                    .padding(.bottom)
                
                if(locationSearchText.isEmpty){
                    Section {
                        popularPlaces
                    } header: {
                        Text("Popular Places")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .animation(.snappy, value: locationSearchText)
                } else {
                    searchingLocations
                        .animation(.snappy, value: locationSearchText)
                }
                
                Spacer()
            }
            .padding()
        }
    }

    
    var locationSearchBar: some View {
        HStack{
            Image(systemName: "location.magnifyingglass")
            TextField(prompt, text: $locationSearchText, prompt: ((selectedLocation != nil) ? Text(selectedLocation!.name) : nil))
            Button(role: .destructive) {
                if(locationSearchText.isEmpty) {
                    selectedLocation = nil
                } else {
                    locationSearchText = ""
                }
            } label: {
                Image(systemName: "xmark.circle").foregroundStyle(.foreground)
            }
        }
        .padding()
        .applyBoxShadowEffect()
        
    }
    
    var popularPlaces: some View {
        ForEach(model.popularPlaces) { place in
            makeLocationButton(place)
                .id(place.id)
            Divider()
        }
    }
    
    var searchingLocations: some View {
        ForEach(model.fuzzyPlaceSearch(locationSearchText)) { place in
            makeLocationButton(place)
                .id(place.id)
            Divider()
        }
    }
    
    @ViewBuilder
    private func makeLocationButton(_ place: Location) -> some View {
        Button {
            selectedLocation = place
            onSubmit()
        } label:  {
            HStack {
                Image(systemName: "signpost.right")
                Text(place.name)
                    .foregroundStyle(.foreground)
            }
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {

    LocationFinder("Location", selection: .constant(nil))
        .initiateServices()
}
