//
//  LocationSelector.swift
//  VRent
//
//  Created by Arun R G on 31/07/24.
//

import SwiftUI

struct LocationFinder: View {
    @EnvironmentObject var model: Model
    @Binding var selectedLocation: SearchLocation?
    @State private var locationSearchText: String = ""
    private let onSubmit: ()->Void
    
    init(selection: Binding<SearchLocation?>, onSubmit: @escaping ()->Void = {}) {
        self._selectedLocation = selection
        self.onSubmit = onSubmit
    }

    
    var locationSearchBar: some View {
        HStack{
            Image(systemName: "location.magnifyingglass")
            TextField("Pickup Location", text: $locationSearchText, prompt: ((selectedLocation != nil) ? Text(selectedLocation!.name) :  nil))
            Button(
                role: .destructive,
                action: { locationSearchText = "" },
                label: { Image(systemName: "xmark.circle").foregroundStyle(.foreground) })
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

    
    var body: some View {
        VStack(alignment: .leading) {
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
    
    @ViewBuilder
    private func makeLocationButton(_ place: SearchLocation) -> some View {
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
        }
    }
}

#Preview {

    LocationFinder(selection: .constant(nil))
        .environmentObject(Model())
}
